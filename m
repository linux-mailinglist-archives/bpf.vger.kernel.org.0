Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB684254A19
	for <lists+bpf@lfdr.de>; Thu, 27 Aug 2020 18:00:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726854AbgH0QAE (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 27 Aug 2020 12:00:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726234AbgH0QAD (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 27 Aug 2020 12:00:03 -0400
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54FBFC061264
        for <bpf@vger.kernel.org>; Thu, 27 Aug 2020 09:00:01 -0700 (PDT)
Received: by mail-yb1-xb2d.google.com with SMTP id e187so3225918ybc.5
        for <bpf@vger.kernel.org>; Thu, 27 Aug 2020 09:00:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=/llJ76ws27LsT6/YXXpmEzV/LI8WQtmNf2e5yPfGiHc=;
        b=X9NmYUDCLVEUrxSCXhb2zAAr/M+zceBvfem0mszvfvkh8OvUeL3evUjm1Ah7BSj655
         nn6eqZItms8a2HJtCTCm1Zj1HT2WeSYE6TFtiEp+BMr+01eCSFUxxDDV4r+OX00NlvBW
         eb/80OfZob33YdJ+ChhhukW+eEtVx9bPfBybH1xzbXAZMID6Y6xu6Kio0rhPLAeW1Dsz
         NEsQZwcpe97X/Ps0jLDE7zigmXtBICqfJlSzlJ6huTyTBtrtvsLWjHsI5GHDMweiRXWw
         ljOrUBypf4bY1T7gEmFbPwTxTPOw/4Dgc1Ip/wtbHv10/VWRq7BTsTSb/zg4VOrQ/ZTH
         xuqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=/llJ76ws27LsT6/YXXpmEzV/LI8WQtmNf2e5yPfGiHc=;
        b=FRzN0uNPLxXZOZg3DXq4jb6yPvpslW7ekllPPDT3SM36c+nqVhcWUYQ6hz5vzGmoM8
         jperQTy9cklKTeD4iHkgsqFagIJvSve7EHxC/CjSSMlwMk9pw/EElyIAHMOeeFdojwMB
         fMUyP3hCZp0GGHHRHssQy8dbr8pKPA8mCdgxZVhh/Bphxqkigtdfd3RKz3hd67Zm+eiu
         aK1zu04YSeFepjGgawObPyoHi3gdXTUiDLJew+qCFJJTizpU5wFwQ/JtXL9gW5rngQNu
         oqnG5GDpPXtUQwj3NA5QimdvmTmvUrIbO1UJoTRUdBbgqa+SnbZcUAFiqIne4yJpgKL3
         mCSg==
X-Gm-Message-State: AOAM5306ZRjyqCWuhjdybwJt7jxjgYF6dQYupvA8Pachef5I94VkTN0C
        tv1qBz8MOkacbFpQVHLkxKC5FPfuw19U/oX/BuseEo4dW8ML7Q==
X-Google-Smtp-Source: ABdhPJxDJg6dE6zdkinErSi1gaE71M1QTcakW4kSR1PXryYwow68V1kw3iO8Z0SCj0pw26ELF0y4As6iWrWQVgOiztg=
X-Received: by 2002:a05:6902:1025:: with SMTP id x5mr30567454ybt.58.1598543999144;
 Thu, 27 Aug 2020 08:59:59 -0700 (PDT)
MIME-Version: 1.0
From:   Abhishek Vijeev <abhishek.vijeev@gmail.com>
Date:   Thu, 27 Aug 2020 21:29:47 +0530
Message-ID: <CAHhV9ERe4VwPrrwDJF4xqmaeyqQqPvYaY2Wb9DEk8tf-GB_-Yw@mail.gmail.com>
Subject: Frozen Maps
To:     bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi,

From a user-space process, given a BPF map file descriptor, is it
possible to determine whether the map is frozen (with BPF_MAP_FREEZE)?

As far as I'm aware, the only way to retrieve information about BPF
maps from file descriptors is to use BPF_OBJ_GET_INFO_BY_FD. However,
I do not see a field which tells me whether a map is frozen (or not)
in struct bpf_map_info
(https://github.com/torvalds/linux/blob/master/include/uapi/linux/bpf.h#L4035).
Kindly correct me if I'm wrong.

Thank you,
Abhishek Vijeev.
