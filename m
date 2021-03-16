Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9DB633D650
	for <lists+bpf@lfdr.de>; Tue, 16 Mar 2021 16:01:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237651AbhCPPB2 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 16 Mar 2021 11:01:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230227AbhCPPBN (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 16 Mar 2021 11:01:13 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2192C06174A;
        Tue, 16 Mar 2021 08:01:12 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id 15so20873537ljj.0;
        Tue, 16 Mar 2021 08:01:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NNvjVz1vaYlHJshO7OABYsYjC9M/PbANTgTBjitjTL4=;
        b=sTr2THG5sRsL6Ywlm61WFLumBxXwk1mAoSr1oOk5jccLunuf//Jcwm65OF4gE61h3a
         ZDO84SV2qOAw9kvZUcWq21efOrWAEcJAyyl3sBUHrQM2OORex+5tiV8OeV4jBoEO7iPU
         ugJGUsHKJOlghl5t+FxUfz0YopgLDMkRtjHRyjXNZYkc1MU6boQQCRMLxzmyzr0CIovv
         z84DR+clKjigHbEjmiTfJzWqIrAfdCybba99+TJLyg7KTenrO2kHyYExh1idq0eMO+mb
         4NySouhStDVWNVK1S7VwWCI9tgpcM7p03BIHdHtcXiTPLm5l0mQksUIYrx/FlThC9tEn
         teZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NNvjVz1vaYlHJshO7OABYsYjC9M/PbANTgTBjitjTL4=;
        b=o9jyAhXt748PLBT73yW7iVSjneX0Aw1gpCsJPVtYqf8eSlBxstQCtPvYGR5T1WBbdN
         j2SyUbh1YkZWNaEH7JdkDgwUDT/kTxCX7xw1hy4HYi/7NUYeR8NbeCHqWBsp+OerAty5
         IRMsVuLA1CwtcKLqeEcuFUQ/AqaUvhKhuAzml3BEYYDHNTdz9AP31d7q4/S7OuozCuiG
         uWlzb0kFdwCZfElTme/lDu+yzxYtqBnvrnig54i2BTsBN6geosr2HfnKJOcaTiqvSWy7
         sRlxzJ1AHlJXkhe/OSw10DmkxV1ESD94ZqxZPod3T6EoNGbmkXB7+kJAHpl6EMleGni3
         Vj3w==
X-Gm-Message-State: AOAM532N4Wf8Zf9NVP40jwfHZH61A+Ac92uZ2k/g+0yO49CJ04ewDqqb
        4V3/zx47O5eVxiUaGRhzj0Opg6VGUo9ywhNnrs4=
X-Google-Smtp-Source: ABdhPJxPqaGNyiwjULN2DKgfnb4h1VL+o5r2Ai3b5TQE/Q+Z2mYX5ge5RX0uAM50vxiqtToFhzBdlsB4i43aki//iB4=
X-Received: by 2002:a2e:3608:: with SMTP id d8mr2980276lja.21.1615906870926;
 Tue, 16 Mar 2021 08:01:10 -0700 (PDT)
MIME-Version: 1.0
References: <20210315085816.21413-1-qiang.zhang@windriver.com> <DM6PR11MB4202D95C3B579C7A6F381A97FF6B9@DM6PR11MB4202.namprd11.prod.outlook.com>
In-Reply-To: <DM6PR11MB4202D95C3B579C7A6F381A97FF6B9@DM6PR11MB4202.namprd11.prod.outlook.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Tue, 16 Mar 2021 08:00:59 -0700
Message-ID: <CAADnVQ+r=8xRjsjFq0Kq0EV-s10AqCsuTjwmP1JDA3NnyiuOKw@mail.gmail.com>
Subject: Re: [PATCH v2] bpf: Fix memory leak in copy_process()
To:     "Zhang, Qiang" <Qiang.Zhang@windriver.com>
Cc:     "ast@kernel.org" <ast@kernel.org>,
        "daniel@iogearbox.net" <daniel@iogearbox.net>,
        "andrii@kernel.org" <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        "kpsingh@kernel.org" <kpsingh@kernel.org>,
        "dvyukov@google.com" <dvyukov@google.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "syzbot+44908bb56d2bfe56b28e@syzkaller.appspotmail.com" 
        <syzbot+44908bb56d2bfe56b28e@syzkaller.appspotmail.com>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Mar 16, 2021 at 4:29 AM Zhang, Qiang <Qiang.Zhang@windriver.com> wrote:
>
> Hello Alexei Starovoitov Daniel Borkmann
> Please  review this patch.

Please don't top post.
