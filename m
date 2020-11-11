Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA9932AE4F8
	for <lists+bpf@lfdr.de>; Wed, 11 Nov 2020 01:39:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731713AbgKKAjU (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 10 Nov 2020 19:39:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727275AbgKKAjT (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 10 Nov 2020 19:39:19 -0500
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C141C0613D1;
        Tue, 10 Nov 2020 16:39:19 -0800 (PST)
Received: by mail-qt1-x842.google.com with SMTP id g15so178220qtq.13;
        Tue, 10 Nov 2020 16:39:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:user-agent:in-reply-to:references:mime-version
         :content-transfer-encoding:subject:to:cc:from:message-id;
        bh=VYGpBgc1MoESrTqe5G/8yvpuLVhdkwv6SHhqO98wwyo=;
        b=scrNLD856fiumyXSZAaMMylKAXtgzTaBxuSnugJreRoJAmulCchAxrNmPlrxytdsXf
         h9moCjqcoqHrPV31YpSuVOhSqyxkFheJ4PSH+zsl8VRcIELt3qHP3RWQidqdSh+pyytD
         xRQzm6XYOMRxhngFEVu1zk5aoR4V1Xge6ciaMFLtL2Ajt6uQvMcSd2cQpY4BHN+5dOUG
         Ib5U9zmLXuDcD+zKQ+FY09qOHw86ncb5uAe+Jk110W78a+tGHurZ8KwEmoRQsONxJNrh
         Pn5qKOTmGqubU10jk2CglhXqakioisiNKdFoqtOGH80QAgamtsbPf4bjxYUnzABGitfy
         WHzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:user-agent:in-reply-to:references
         :mime-version:content-transfer-encoding:subject:to:cc:from
         :message-id;
        bh=VYGpBgc1MoESrTqe5G/8yvpuLVhdkwv6SHhqO98wwyo=;
        b=i1Cql8EQ7A4zG1SQkDZdUdTk0QZkvQ0/NJKNvHhl4PkD8r0Kfz3r+dhRAYaNRbHkM2
         1Vz/gez5hCmZ4BQzc530nXAlfQJdgC5d2KTcX9HuFmWFxlh5AnONxjm9GuUSGUsEiZFI
         FoB7j26fXkTJSNNvbrRqt1gp2yuXBL1aE7iSxTKuIHPpqdQsA1khEHy516r+1iAEfhcn
         zTxZbkEqD1hvz35H5DpG3Jl1orZORo3zzPwKsKZS05RrNs4Qq4pI+Er2mZFitM6UNuac
         wOHo7JQ+9ET1KDSa9gGyw+3eTZKshCFhjP6MrcM6I6PyNz/L7pVNU5uCcq2/jwv/OarP
         cmcQ==
X-Gm-Message-State: AOAM533HMZCuvX8Fv/4CLngaQxM+WpjUlPu4Xm0KIV5LmyWuJcJx1Bpb
        bgJELJjjeS704MyxSgg5YrvReYW3990YSw==
X-Google-Smtp-Source: ABdhPJyNbcv+8Xlng2UeY+pHn7hiHvVtmvaY4X7hJEYOiA6jWFsg48gMa9sjwgjWH5q6VNLq1Sb5rw==
X-Received: by 2002:ac8:42d1:: with SMTP id g17mr20542476qtm.191.1605055158576;
        Tue, 10 Nov 2020 16:39:18 -0800 (PST)
Received: from [192.168.86.242] ([179.97.37.151])
        by smtp.gmail.com with ESMTPSA id p12sm484233qkp.88.2020.11.10.16.39.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Nov 2020 16:39:17 -0800 (PST)
Date:   Tue, 10 Nov 2020 21:38:53 -0300
User-Agent: K-9 Mail for Android
In-Reply-To: <CAEf4Bzb9CJeZKxJ=Ppdpsb_1qZ2nSOTmRyk1Lj_wok0sH8NZ_w@mail.gmail.com>
References: <20201106052549.3782099-1-andrii@kernel.org> <CAEf4BzZGXQaDEwASyaJ39AAZ7TWnbi89pgrwXB5uFi861c9CCA@mail.gmail.com> <348BC25F-0DDF-416E-8659-0C4B09F0A767@gmail.com> <CAEf4Bzb9CJeZKxJ=Ppdpsb_1qZ2nSOTmRyk1Lj_wok0sH8NZ_w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH dwarves 0/4] Add split BTF support to pahole
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
CC:     Andrii Nakryiko <andrii@kernel.org>, dwarves@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        bpf <bpf@vger.kernel.org>, Kernel Team <kernel-team@fb.com>
From:   Arnaldo <arnaldo.melo@gmail.com>
Message-ID: <334FAF0A-CA0A-448C-8317-235EEB44C7A6@gmail.com>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On November 10, 2020 9:35:25 PM GMT-03:00, Andrii Nakryiko <andrii=2Enakry=
iko@gmail=2Ecom> wrote:
>On Tue, Nov 10, 2020 at 4:30 PM Arnaldo <arnaldo=2Emelo@gmail=2Ecom> wrot=
e:
>> On November 10, 2020 8:34:18 PM GMT-03:00, Andrii Nakryiko
><andrii=2Enakryiko@gmail=2Ecom> wrote:
>> >On Thu, Nov 5, 2020 at 9:25 PM Andrii Nakryiko <andrii@kernel=2Eorg>
>> >wrote:
>> >>
>> >> Add ability to generate split BTF (for kernel modules), as well as
>> >load split
>> >> BTF=2E --btf_base argument is added to specify base BTF for split
>BTF=2E
>> >This
>> >> works for both btf_loader and btf_encoder=2E
>> >
>> >Arnaldo, can you please take a look at these patches? Would be nice
>to
>> >get them landed ASAP so that we can start testing out kernel module
>> >BTFs without locally applying patches first=2E Thanks!
>>
>>
>> I've been working on prepping up v1=2E19, will process these patches
>first thing in the morning, tomorrow,
>>
>
>Thanks! Do you plan to include these changes into v1=2E19 as well?


Lemme test it tomorrow morning=2E

- Arnaldo
--=20
Sent from my Android device with K-9 Mail=2E Please excuse my brevity=2E
