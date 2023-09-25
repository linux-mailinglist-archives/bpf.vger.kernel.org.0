Return-Path: <bpf+bounces-10763-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 160907ADE90
	for <lists+bpf@lfdr.de>; Mon, 25 Sep 2023 20:22:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 07CB3281607
	for <lists+bpf@lfdr.de>; Mon, 25 Sep 2023 18:22:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9169D224E2;
	Mon, 25 Sep 2023 18:22:24 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95A3A1D523
	for <bpf@vger.kernel.org>; Mon, 25 Sep 2023 18:22:22 +0000 (UTC)
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com [IPv6:2607:f8b0:4864:20::1132])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2521610C;
	Mon, 25 Sep 2023 11:22:21 -0700 (PDT)
Received: by mail-yw1-x1132.google.com with SMTP id 00721157ae682-59f4bc88f9fso57358537b3.2;
        Mon, 25 Sep 2023 11:22:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695666140; x=1696270940; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dEdoLWk7hr93lYo85cFiSYxcDqCG5HY3UkZKa6gp7n8=;
        b=OAh6had7vUse9heF5fQAMHUa9ykBGce8/q0+EXNKvN6H/gm2FdblK8zBWfMnwYccyX
         AEy7/ztqv30wPjyRa1Q36hh7IXPS9Vug0IntxmtGXiCqF2n2aTSlZgteivBF2ytW5IVi
         FskV+eYRguiQ9wa8e4x5q6nSiNYuiSx0T9nK07BAhgL/ZJPoVxbX88yREeTkiJd7i9ys
         BW6m0gVEl2R3a4a5NXdzT8CtHg6mozOrQ3xEsOZkuFBbZIpf1aoMIQ813qajEHVaxeBb
         7EqFWzFHOBnNyLrj5inTfKWqxHGqH9WPD5pUIyV9g0EIqfDAj6yreiWgHawM264wZUNW
         MOWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695666140; x=1696270940;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dEdoLWk7hr93lYo85cFiSYxcDqCG5HY3UkZKa6gp7n8=;
        b=PPtU93oskx0hrO7t+SY4+HKOevg14LnZPtKPm7/GdcoqXEP/MiwKG15SvOJCCfzCxM
         Dy5tonlley4EA8d/NwOLkpSXCtaUnm1gcwkGpTXBQxjSiX8+HDB7TFiY04dtVhPfGBSs
         FGQ606SBj2akYC6DeVe/h5qpWFNZztqwiAmTQoAham0nAddWmdcAh1etxhHAmVuLzfAf
         D7rAQ2o5A2qZ5chjM6pSXpGXjZZ+UsiJobeUSjajp897wwUlv6TMGLhIzqEgukPL9eG3
         1XxuCsr7v1+7zNLUpVn9tZoawNnBaPfK7g9JtiMGGfJ/dnh8Ipju3KvKbRNjrXE2NhCy
         0O8g==
X-Gm-Message-State: AOJu0YwM9yzkp1VTm91blo2vKSS+X3baNVgi6hUTwdheVfCtODuul0Y6
	PEw7eLiqqow4LnrwT2GBr0c=
X-Google-Smtp-Source: AGHT+IGZgUFRmCujMKoJPRRZC5MZVoY8cTeyvHyupJbS8eIfGShoFbkNWLmJzbrmYHSA0nkVgkrk/w==
X-Received: by 2002:a0d:e283:0:b0:592:5475:6c0f with SMTP id l125-20020a0de283000000b0059254756c0fmr6380313ywe.27.1695666140308;
        Mon, 25 Sep 2023 11:22:20 -0700 (PDT)
Received: from ?IPV6:2600:1700:6cf8:1240:f7cd:fd6d:2b89:f093? ([2600:1700:6cf8:1240:f7cd:fd6d:2b89:f093])
        by smtp.gmail.com with ESMTPSA id g1-20020a81ae41000000b0059f766f9750sm775831ywk.124.2023.09.25.11.22.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Sep 2023 11:22:19 -0700 (PDT)
Message-ID: <9e83bda8-ea1b-75b9-c55f-61cf11b4cd83@gmail.com>
Date: Mon, 25 Sep 2023 11:22:17 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [RFC PATCH bpf-next 0/8] bpf, cgroup: Add bpf support for cgroup
 controller
To: Yafang Shao <laoar.shao@gmail.com>, ast@kernel.org, daniel@iogearbox.net,
 john.fastabend@gmail.com, andrii@kernel.org, martin.lau@linux.dev,
 song@kernel.org, yonghong.song@linux.dev, kpsingh@kernel.org,
 sdf@google.com, haoluo@google.com, jolsa@kernel.org, tj@kernel.org,
 lizefan.x@bytedance.com, hannes@cmpxchg.org, yosryahmed@google.com,
 mkoutny@suse.com
Cc: cgroups@vger.kernel.org, bpf@vger.kernel.org
References: <20230922112846.4265-1-laoar.shao@gmail.com>
Content-Language: en-US
From: Kui-Feng Lee <sinquersw@gmail.com>
In-Reply-To: <20230922112846.4265-1-laoar.shao@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 9/22/23 04:28, Yafang Shao wrote:
> Currently, BPF is primarily confined to cgroup2, with the exception of
> cgroup_iter, which supports cgroup1 fds. Unfortunately, this limitation
> prevents us from harnessing the full potential of BPF within cgroup1
> environments.
> 
> In our endeavor to seamlessly integrate BPF within our Kubernetes
> environment, which relies on cgroup1, we have been exploring the
> possibility of transitioning to cgroup2. While this transition is
> forward-looking, it poses challenges due to the necessity for numerous
> applications to adapt.
> 
> While we acknowledge that cgroup2 represents the future, we also recognize
> that such transitions demand time and effort. As a result, we are
> considering an alternative approach. Instead of migrating to cgroup2, we
> are contemplating modifications to the BPF kernel code to ensure
> compatibility with cgroup1. These adjustments appear to be relatively
> minor, making this option more feasible.

Do you mean giving up moving to cgroup2? Or, is it just a tentative
solution?


