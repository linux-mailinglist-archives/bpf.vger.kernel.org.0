Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD4CA204F90
	for <lists+bpf@lfdr.de>; Tue, 23 Jun 2020 12:51:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732339AbgFWKvb (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 23 Jun 2020 06:51:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732348AbgFWKvb (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 23 Jun 2020 06:51:31 -0400
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AD8EC061755
        for <bpf@vger.kernel.org>; Tue, 23 Jun 2020 03:51:29 -0700 (PDT)
Received: by mail-lf1-x143.google.com with SMTP id g139so10605966lfd.10
        for <bpf@vger.kernel.org>; Tue, 23 Jun 2020 03:51:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=references:user-agent:from:to:cc:subject:in-reply-to:date
         :message-id:mime-version;
        bh=jAVX5qNY3xX90Cjh1Jp/0eHcv8V0BN7tJ1RLPzcNmkY=;
        b=j5JxL8i2bmFYP+AJWUrt5NYM1E/hZ1+g76xW4twVTVGKD3ts2RRa6z2EYc2m9ZnAkp
         htcEhGDxIgIlsNHBS1Kmk/5YEfxOlOtC9VxcyKfPjjSuaDzF4BDD4oDVTHMFcMHHqNc1
         ohAVpEy+3IDrl8Ar9rrgMHqEYJeqWhluuXYJY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject
         :in-reply-to:date:message-id:mime-version;
        bh=jAVX5qNY3xX90Cjh1Jp/0eHcv8V0BN7tJ1RLPzcNmkY=;
        b=phKhjoOb/u+k0Xqz8zv77MtXB8G3U/LNBiB8O0eYfxm4xKXHRRNB8PiiWpI79BiPsV
         TPMF9NhS5zEEVI2BV2zVZXpR6x9s1PZ8bcuBL4n8uro9xNeO+Cz4br01Gcd5ahlDR7J5
         IjIFcgI25pWd3Dvz1V7a4eShKdqE9KSFk6W7Koz6HTm4MXUyw+3pJdN00vDifaCWH17k
         ZLs0b1MRDFanZVh2hpjGNb3TtbkWKuaqBnRMvdE9m0hplg6PlzZ/X2iQ5KF9B/cUTPZe
         kjA9lX216ulgZgmCEpxg6nb6Evjt6hBedZtjOOLToRJav62GO2qwh0rCevp7v3ZgPsz3
         aLcQ==
X-Gm-Message-State: AOAM5309/QVoWcX2oi86gU3COemWo3rX6UT8yCr8vr55XJErk4NEL9uX
        R3j61USuWm0SlqvKTzyzxysacQ==
X-Google-Smtp-Source: ABdhPJxbnGdD/ZA++Wu2bUgEA8N29ibeSN0ZMP0hSCkMfEx4C/B2e6V4J2ZR13lythD02XxEYCmb5w==
X-Received: by 2002:a19:8407:: with SMTP id g7mr12472742lfd.61.1592909487933;
        Tue, 23 Jun 2020 03:51:27 -0700 (PDT)
Received: from cloudflare.com ([2a02:a310:c262:aa00:b35e:8938:2c2a:ba8b])
        by smtp.gmail.com with ESMTPSA id q190sm3200937ljb.29.2020.06.23.03.51.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jun 2020 03:51:27 -0700 (PDT)
References: <20200622160300.636567-1-jakub@cloudflare.com> <20200622160300.636567-3-jakub@cloudflare.com> <CAEf4BzYY8NcmprF-V3SxBgiF0mqNpK-qrymt=wvz6iCON=geiw@mail.gmail.com>
User-agent: mu4e 1.1.0; emacs 26.3
From:   Jakub Sitnicki <jakub@cloudflare.com>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Networking <netdev@vger.kernel.org>,
        kernel-team@cloudflare.com
Subject: Re: [PATCH bpf-next 2/3] bpf, netns: Keep attached programs in bpf_prog_array
In-reply-to: <CAEf4BzYY8NcmprF-V3SxBgiF0mqNpK-qrymt=wvz6iCON=geiw@mail.gmail.com>
Date:   Tue, 23 Jun 2020 12:51:26 +0200
Message-ID: <87tuz2m4wh.fsf@cloudflare.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Jun 23, 2020 at 08:23 AM CEST, Andrii Nakryiko wrote:
> On Mon, Jun 22, 2020 at 9:04 AM Jakub Sitnicki <jakub@cloudflare.com> wrote:
>>
>> Prepare for having multi-prog attachments for new netns attach types by
>> storing programs to run in a bpf_prog_array, which is well suited for
>> iterating over programs and running them in sequence.
>>
>> Because bpf_prog_array is dynamically resized, after this change a
>> potentially blocking memory allocation in bpf(PROG_QUERY) callback can
>> happen, in order to collect program IDs before copying the values to
>> user-space supplied buffer. This forces us to adapt how we protect access
>> to the attached program in the callback. As bpf_prog_array_copy_to_user()
>> helper can sleep, we switch from an RCU read lock to holding a mutex that
>> serializes updaters.
>>
>> To handle bpf(PROG_ATTACH) scenario when we are replacing an already
>> attached program, we introduce a new bpf_prog_array helper called
>> bpf_prog_array_replace_item that will exchange the old program with a new
>> one. bpf-cgroup does away with such helper by computing an index into the
>> array based on program position in an external list of attached
>> programs/links. Such approach seems fragile, however, when dummy progs can
>> be left in the array after a memory allocation failure on link release.
>
> bpf-cgroup can have the same BPF program present multiple times in the
> effective prog array due to inheritance. It also has strict
> guarantee/requirement about relative order of programs in parent
> cgroup vs child cgroups. For such cases, replacing a BPF program based
> on its pointer is not going to work correctly.

Thanks for the explanation. That did not occur to me. Incorporated it
into the description in v2.

>
> We do need to make sure that cgroup detachment never fails by falling
> back to replacing BPF prog with dummy prog, though. If you are
> interested in a challenge, you are very welcome to do that! :)

I keep a list of tasks for a slow day.

[...]
