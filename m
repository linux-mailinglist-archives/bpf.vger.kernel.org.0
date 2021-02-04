Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5FF2E30E8E4
	for <lists+bpf@lfdr.de>; Thu,  4 Feb 2021 01:49:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234494AbhBDAsa (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 3 Feb 2021 19:48:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234537AbhBDArs (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 3 Feb 2021 19:47:48 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69853C0613D6
        for <bpf@vger.kernel.org>; Wed,  3 Feb 2021 16:47:05 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id q7so1401421wre.13
        for <bpf@vger.kernel.org>; Wed, 03 Feb 2021 16:47:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YsUsijAn5uzgVNje1CwhCwQjGSwkDy+N1DNj8t3+1lE=;
        b=yS462cfzIMlf3BDPWlQzPUncYBQkCPKk25pPmWPVtMO9NSCGPtBu/vvUvWJoo51Vrq
         MVG+NuovOYbihB+eNbOHlfzWN+vWfy8oLnkfzYEprqquSoztw3XXQSkzM2baoz6RvcbW
         GyZioxKly+IvOQrqa55jzA9TDen/AYUV7rZIkQzMuF7WuR6mWoAU6oVUMkEd4npBqxP4
         ewotQFSIKQsIAf+gv4gFccQ9JdBRwQnGRQ9GspmHRzYnoHHSxAtrjqS+My6pDyq1MlYs
         b61Pc556NmmbqQbDaC5XH6n0IB54RmFuXNTrRpsDx/jzRvyJL4zOpthhjF42oE78vy8i
         3nQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YsUsijAn5uzgVNje1CwhCwQjGSwkDy+N1DNj8t3+1lE=;
        b=DniAWCxu8AZQrF2Nz72D7c98auL7rV5Ad7jkvYPf52zlNbc/HZqOqhZf4Kqru5z55A
         8XNEwsxXP9AcNVbE5SY9J+68A1S+GmF4m6ICHpzD6dv2IMuFxfX6jizyC78eIIf19T1O
         ua98gxNFKVsUpxlqFrKl+xDsDALHNDRRuJcOv0F4u90k5NIr2RRXooNL9Z8IKEgrbSZw
         xHR1s8KANOJW698EgDe0EkOEfVyfTyJjaRkLLgdkAwRFaAFogbpvoZgU1Dxj5dgNqW+G
         Z+F/Vz6uSEhd8DxZ+i56byMe5DMnRZlnA2SsVoJd5IbKATVsm6Rn9i5VtK9aPI8L7tHG
         JxUg==
X-Gm-Message-State: AOAM531m6yc3swxzPpT5yuMGAs9X1x8s9uaWtGr4eVHq9YtxjhopWutQ
        O3CaCalIXy5ZRnO3A+aIITNPOvk2lmJXJ+E7vOUmNw==
X-Google-Smtp-Source: ABdhPJz/l71JnKXpEjHlQUBhpkhX+AfeEt20fOi3627lhpFpY+FFIVBDlLCcrmrzz5TqkMxed2C0VMMEmp3tdC0+FkY=
X-Received: by 2002:a5d:414f:: with SMTP id c15mr6319496wrq.42.1612399624135;
 Wed, 03 Feb 2021 16:47:04 -0800 (PST)
MIME-Version: 1.0
References: <CAJCQCtSQLc0VHqO4BY_-YB2OmCNNmHCS6fNdQKmMWGn2v=Jpdw@mail.gmail.com>
 <CAJCQCtRHOidM7Vps1JQSpZA14u+B5fR860FwZB=eb1wYjTpqDw@mail.gmail.com> <CAEf4BzZ4oTB0-JizHe1VaCk2V+Jb9jJoTznkgh6CjE5VxNVqbg@mail.gmail.com>
In-Reply-To: <CAEf4BzZ4oTB0-JizHe1VaCk2V+Jb9jJoTznkgh6CjE5VxNVqbg@mail.gmail.com>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Wed, 3 Feb 2021 17:46:48 -0700
Message-ID: <CAJCQCtRw6UWGGvjn0x__godYKYQXXmtyQys4efW2Pb84Q5q8Eg@mail.gmail.com>
Subject: Re: 5:11: in-kernel BTF is malformed
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This is just the vmlinuz-5.11.0-0.rc6.141.fc34.x86_64 file

https://drive.google.com/file/d/1G_2qLVRIy-ExaJI1-cTqDssrDu3sWo-m/view?usp=sharing
