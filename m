Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89FCE28907B
	for <lists+bpf@lfdr.de>; Fri,  9 Oct 2020 20:03:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387942AbgJISDc (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 9 Oct 2020 14:03:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732013AbgJISDc (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 9 Oct 2020 14:03:32 -0400
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com [IPv6:2607:f8b0:4864:20::b2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A2C1C0613D2
        for <bpf@vger.kernel.org>; Fri,  9 Oct 2020 11:03:32 -0700 (PDT)
Received: by mail-yb1-xb2b.google.com with SMTP id a2so7912492ybj.2
        for <bpf@vger.kernel.org>; Fri, 09 Oct 2020 11:03:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qhlDX71sTiSBJhipYwS+BG2VrGVBYHklqWzEm46/fEE=;
        b=fiSJdy7gTPwUcfJPuA+AsoXObKX+jxeQ5jTsKcNyqmroaBFjglFGekJKKmtaoXMP/g
         uy4cX5ZMvc8srFdmuz09zXtnUbvKJRvoVls6/tZZZ/Yxy8fYVQgM6QNBueHqAyvbOlOh
         RvVFA3L6a/tzEHrgTHB/jRfdFY9G+0IbPW3C2zVplwm65f7FAZFpM1VtF6ozcl5so9Vz
         hiLx3wJOR8VTiZ9FdwRYlt1F1jsLXSquvfpsVwuzikoKNiY7VCV6npAscSurum4FNI8V
         h0hs2x1QKh141bkzOLm1jeV4K45YXZOl3Vjo4CshIZSJUTo4iZC15GIidbuZj8opekG6
         0zSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qhlDX71sTiSBJhipYwS+BG2VrGVBYHklqWzEm46/fEE=;
        b=Zq1adeqGrLCjiXCcPOOV+7PFUhOtq3fLapehUfobXXbrO9AibGbgJzl2WW9vNBzIV4
         CROXr47AFFk598//xuSI3/f8gqSAJwjw0nRMy+13PjuHV42qbasuIPqIUuBFvnZjFLuO
         aWbhK+xbtplCRkOQaXeb9DqBGbK7WxnvbI+f+/ij/iqtZacyr5Bvp04Wiw2vlPguBNwt
         lEnCGogoC9Z3FY5nQRqEc0roGaneKRU3UoJDSquFya9dWSv4o70sC6n80PbB8n+0knX5
         xKW9wmyGmdHZBR6U2VinuGbpDfMab7KNoCwLaYQKy8dcjkURc6OjFlVELdgpFMAnu+YK
         qMUg==
X-Gm-Message-State: AOAM53162GNw7w7z77kqEfg+kx7GE8ZiylHPeCYw/1+TcjnQPVhW7aeN
        Q8tQAm4JRxEPPr0IuR5pCEXsqcuCkyza5krNwpY=
X-Google-Smtp-Source: ABdhPJwHYDhoBQeSHSGDOZxSQ1Rj1sWrw7FB8q/+nOAGUXdqiQJXpfX+CSU1nOhfhPoVFnT28BpuWERRbLDtRRLacKQ=
X-Received: by 2002:a25:b0d:: with SMTP id 13mr10491446ybl.347.1602266611277;
 Fri, 09 Oct 2020 11:03:31 -0700 (PDT)
MIME-Version: 1.0
References: <CAMy7=ZUk08w5Gc2Z-EKi4JFtuUCaZYmE4yzhJjrExXpYKR4L8w@mail.gmail.com>
In-Reply-To: <CAMy7=ZUk08w5Gc2Z-EKi4JFtuUCaZYmE4yzhJjrExXpYKR4L8w@mail.gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Fri, 9 Oct 2020 11:03:20 -0700
Message-ID: <CAEf4BzYTja99-1LHdMK69qY3XrqgtyKVheV3YH7e89JY0C4E1A@mail.gmail.com>
Subject: Re: libbpf error: unknown register name 'r0' in asm
To:     Yaniv Agman <yanivagman@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Daniel Borkmann <daniel@iogearbox.net>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Oct 9, 2020 at 9:06 AM Yaniv Agman <yanivagman@gmail.com> wrote:
>
> Pulling the latest changes of libbpf and compiling my application with it,
> I see the following error:
>
> ../libbpf/src//root/usr/include/bpf/bpf_helpers.h:99:10: error:
> unknown register name 'r0' in asm
>                      : "r0", "r1", "r2", "r3", "r4", "r5");

are you including bpf_helpers.h from user-space code? You are using
recent enough Clang to not run into this problem for -target bpf, so
this seems like you are including bpf_helpers.h in the context where
it's not supposed to be included.


>
> The commit which introduced this change is:
> 80c7838600d39891f274e2f7508b95a75e4227c1
>
> I'm not sure if I'm doing something wrong (missing include?), or this
> is a genuine error
>
> Yaniv
