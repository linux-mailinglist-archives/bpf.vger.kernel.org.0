Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47B8231080A
	for <lists+bpf@lfdr.de>; Fri,  5 Feb 2021 10:38:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230249AbhBEJhu (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 5 Feb 2021 04:37:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230086AbhBEJfj (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 5 Feb 2021 04:35:39 -0500
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 645D9C06178A;
        Fri,  5 Feb 2021 01:34:58 -0800 (PST)
Received: by mail-qk1-x731.google.com with SMTP id a19so6289205qka.2;
        Fri, 05 Feb 2021 01:34:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:user-agent:in-reply-to:references:mime-version
         :content-transfer-encoding:subject:to:cc:from:message-id;
        bh=RyOsYdR/cTpzVTwmGomv9xYgS+mZh3bKQ7rv1DKeR6w=;
        b=Of0I76MkY8mE2TY8W3XTizCoTfJ9YcnTI+sUVrvvYt7zNe2A92zTzfpR2sEB52ust4
         OqaCUvo9yDaCulFSorXIG2PypR+vS801Nkw+7z+II53UZfV6QoTinsyvDHK7szVPFI8r
         pfpWO7NIjSdDypDrkJ3S0fvnXGVT8A6oE/pL+PEeUO1ELPhURMlgCo2BPKCIcSjSEn/F
         NwA/BR6XjoR7NZs64lOeHiHB3RCHNHXuGll1EUAjFxFjW+IAvXKZevVZp9ZpfPLuosZ9
         ofMJbZgiglpppUz724XnDzl1cZZOVbjfMdgVsSD46UH8oOSue4vjIBx/vuW/iApZxH4o
         58Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:user-agent:in-reply-to:references
         :mime-version:content-transfer-encoding:subject:to:cc:from
         :message-id;
        bh=RyOsYdR/cTpzVTwmGomv9xYgS+mZh3bKQ7rv1DKeR6w=;
        b=jBCuwKW/vs6oSo/n+S/GLeGh0gqfagciiXqlreZfEl0m45ymP6PJ+PdVdQ1aar6il+
         CS1ViH7R1JhmF0I2FXZPjweqL1+XzYtTyyVqrhAk4JbIo47SLcIqSDOlJeHVhSko17gu
         ru52VCLWlX4Yz6EdN8Vw4huYrwmnIXruS3PYdb5X8nDndFhLFgMfGkdapxNv0ZRwtcEB
         IFvGJQHZPAV9SMu0oWqlAO0i/BkrCEeGObOhAI8t85IQn8HfXzUfdxz/hDIMSmTgFn45
         IQg+oDgIu5uLrJCOS241RN4L9rBCbCkmip4VtOI4D4VGYg0/CABUPluM+rih4If9607H
         RX1g==
X-Gm-Message-State: AOAM530MDxDSgIOVDhJ9mSiReRKU+VCZt6YfFAGEpE4Fko8hHSWsAzPq
        5YQk0axXgY089MuTaqb1ll9a0QGAVGcLqA==
X-Google-Smtp-Source: ABdhPJxWYuW1W5C5/YDt0DT9CqM9NazHBc5cY6wwlA8DYAi2hTgOqS/lG4Ugj5qaqJRlZRMk8f1J0w==
X-Received: by 2002:a37:66c2:: with SMTP id a185mr3456630qkc.30.1612517697516;
        Fri, 05 Feb 2021 01:34:57 -0800 (PST)
Received: from [192.168.86.198] ([179.97.37.151])
        by smtp.gmail.com with ESMTPSA id x62sm3648415qkd.1.2021.02.05.01.34.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Feb 2021 01:34:56 -0800 (PST)
Date:   Fri, 05 Feb 2021 06:33:43 -0300
User-Agent: K-9 Mail for Android
In-Reply-To: <CAEf4BzZf_1g13dA1t6rbi1TFttufyGNaU14pPxo9uK-FVArCbQ@mail.gmail.com>
References: <20210204220741.GA920417@kernel.org> <CAEf4BzY-RbXXW-Ajcvq4fziOJ=tMtT7O76SUboHQyULNDkhthw@mail.gmail.com> <C359F19F-29BC-4F6D-961A-79BFA47F36A7@gmail.com> <CAEf4BzZf_1g13dA1t6rbi1TFttufyGNaU14pPxo9uK-FVArCbQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: ANNOUNCE: pahole v1.20 (gcc11 DWARF5's default, lots of ELF sections, BTF)
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
CC:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        dwarves@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>, Jiri Olsa <jolsa@kernel.org>,
        Jan Engelhardt <jengelh@inai.de>,
        Domenico Andreoli <cavok@debian.org>,
        Matthias Schwarzott <zzam@gentoo.org>,
        Andrii Nakryiko <andriin@fb.com>, Yonghong Song <yhs@fb.com>,
        Mark Wieelard <mjw@redhat.com>,
        Paul Moore <paul@paul-moore.com>,
        Ondrej Mosnacek <omosnace@redhat.com>,
        =?ISO-8859-1?Q?Daniel_P=2E_Berrang=E9?= <berrange@redhat.com>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        Tom Stellard <tstellar@redhat.com>
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Message-ID: <BFDC3C1D-F87D-4F82-BDB0-444629C484CE@gmail.com>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On February 5, 2021 4:39:47 AM GMT-03:00, Andrii Nakryiko <andrii=2Enakryi=
ko@gmail=2Ecom> wrote:
>On Thu, Feb 4, 2021 at 8:34 PM Arnaldo Carvalho de Melo
><arnaldo=2Emelo@gmail=2Ecom> wrote:
>>
>>
>>
>> On February 4, 2021 9:01:51 PM GMT-03:00, Andrii Nakryiko
><andrii=2Enakryiko@gmail=2Ecom> wrote:
>> >On Thu, Feb 4, 2021 at 2:09 PM Arnaldo Carvalho de
>Melo><acme@kernel=2Eorg> wrote:
>> >>         The v1=2E20 release of pahole and its friends is out, mostly
>> >> addressing problems related to gcc 11 defaulting to DWARF5 for -g,
>> >> available at the usual places:
>> >
>> >Great, thanks, Arnaldo! Do you plan to build RPMs soon as well?
>>
>> It's in rawhide already, I'll do it for f33, f32 later,
>>
>
>Do you have a link? I tried to find it, but only see 1=2E19 so far=2E


https://koji=2Efedoraproject=2Eorg/koji/buildinfo?buildID=3D1703678

 - Arnaldo

--=20
Sent from my Android device with K-9 Mail=2E Please excuse my brevity=2E
