Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2BCCA28A9A2
	for <lists+bpf@lfdr.de>; Sun, 11 Oct 2020 21:28:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726417AbgJKT2o (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 11 Oct 2020 15:28:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726333AbgJKT2o (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 11 Oct 2020 15:28:44 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5FA4C0613CE
        for <bpf@vger.kernel.org>; Sun, 11 Oct 2020 12:28:43 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id l24so14720078edj.8
        for <bpf@vger.kernel.org>; Sun, 11 Oct 2020 12:28:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=LvyusU7v//8dKH8l1yHTXdlbUEnfmIOCEh/JmAy0QG4=;
        b=rAbOEtNKmRBrXTs4Yy1V6gMArt3l1WvViMDkq/wGJA5JoRubYeACLUo7uVnFFIIJfx
         zL6xlwiceFPLH4TpUh43+J6qhN587BiwQBhqd0mi03KjHcF+oxQq7uCR+gakB/X3fmus
         jrl/Bg6UjJHOeM2PSm6hMY/dFfQe6Wrse8So+FCqOEi2Ej5I+XqD9hjN9HWD7vTdzgy8
         SWz97W05P28IwdLIyXeXHQyvjazvxyDTe9znpMLAr+k1G8iEmNMPt1eO93H1vPbeuC93
         52G/3HSvautO/4TbgY+Hk4miqdMERYS+RyXBfN/V9DOumnQHJAWFvBJeFzMyEFJI53my
         Y8kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=LvyusU7v//8dKH8l1yHTXdlbUEnfmIOCEh/JmAy0QG4=;
        b=nwKg/gaqf2ZL2M2EZ3ZaIKK3f5FlO2Hjxf9wzgyfE2V0GvvCEIMQ/k/r0Fxnf76WSy
         BeTs+48f/qqYjAGqR5E8q6DaWDumvZ3NeZqkRnSmf5DAqsXkp5TpZXyMCIPME3V6E1Hg
         u/iBEe+Mtom2DosgZ7YWnFYaGqrIdY2MpNko87r8dz9W9Wyzkr/0z2OajxtKrb04JoOz
         DspIPXPYPFZ2AvhOB9w1vCPVGWQqnkN12Un4/HKTK18lEfDergFVPwT+xu2bhX+9NFJ2
         dWwDuE3M37ji46iTL7KOBxt7a2gIW2/fhb7F39h7xSE5GP9peiM9cA8vynFXwYWZjvnl
         +vPg==
X-Gm-Message-State: AOAM533WKVaFRnED5zfBby29zQZ526Y4a8+HkzRm+HlV3uSNDRjZAemp
        kibKXbXTtC9S++WjZLCpOIElyNujXxpJ0Rm+TS6W/vHoyzNFZQ+w
X-Google-Smtp-Source: ABdhPJx7H867WORKRptwnDxR9iyqTiznvBb3QYjCE1I95Uy0uGMyNCUiDJPwgxvIxluS4VN2WYIThCFibkCBftRpQjU=
X-Received: by 2002:aa7:c5c4:: with SMTP id h4mr10726492eds.379.1602444521864;
 Sun, 11 Oct 2020 12:28:41 -0700 (PDT)
MIME-Version: 1.0
From:   Yaniv Agman <yanivagman@gmail.com>
Date:   Sun, 11 Oct 2020 22:28:30 +0300
Message-ID: <CAMy7=ZWoL7w97aR5_02OEjKEkJT8R7OEzpL5Zp8Cycm=yZSLJQ@mail.gmail.com>
Subject: libbpf: Loading kprobes fail on some distros
To:     bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Trying to load kprobes on ubuntu 4.15.0, I get the following error:
libbpf: load bpf program failed: Invalid argument

The same kprobes load successfully using bcc

After some digging, I found that the issue was with the kernel version
given to the bpf syscall. While libbpf calculated the value 265984 for
the kern_version argument, bcc used 266002.
It turns out that some distros (e.g. ubuntu, debian) change the patch
number of the kernel version, as detailed in:
https://github.com/ajor/bpftrace/issues/8

I didn't find a proper API in libbpf to load kprobes in such cases -
is there any?
