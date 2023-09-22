Return-Path: <bpf+bounces-10627-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6ED3A7AB035
	for <lists+bpf@lfdr.de>; Fri, 22 Sep 2023 13:07:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 475162829C3
	for <lists+bpf@lfdr.de>; Fri, 22 Sep 2023 11:07:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D201F1F168;
	Fri, 22 Sep 2023 11:07:04 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E0EC1EA87
	for <bpf@vger.kernel.org>; Fri, 22 Sep 2023 11:07:02 +0000 (UTC)
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FF40195
	for <bpf@vger.kernel.org>; Fri, 22 Sep 2023 04:06:59 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id 4fb4d7f45d1cf-5333fb34be3so2070766a12.1
        for <bpf@vger.kernel.org>; Fri, 22 Sep 2023 04:06:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1695380818; x=1695985618; darn=vger.kernel.org;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:from:to:cc:subject:date:message-id:reply-to;
        bh=wOCT5ExoC5YPQiQiKaq0RQhda2tSHNuc6pgLlFjLqqU=;
        b=IP85yETdfvlmWtTLgQvn/zUWZ4Gn1onznz86Lz4rYiWIbdn4Y4WJqvKXGAdu+Xu3gS
         HAFLueHcvNmr0lvpDtpx6uOjEKTQW193Er89S9fD7nxqECzkY9j/GYOo8E6yoS3XLfh+
         QT+YFHVvARiEdKrEiAJ2qKHRDvoHIwdir1giinji+yHAGMgCy0JC7g9/ysSlJvcnqphD
         UX2Ag+vIVBVMcna86nX27YpoHq3h+hocpMO0d1RF8thmtRtZhhCJZhc5G7Y0QuDv8JEQ
         wYiKibUa1GHCEe0PIb8UtMmGm7fv+4+MYF6ACf1Y6vul3Ks0fmRMsI9ZcDendCicWH1B
         ZzXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695380818; x=1695985618;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wOCT5ExoC5YPQiQiKaq0RQhda2tSHNuc6pgLlFjLqqU=;
        b=XRJuqr1ALsGRRwvzMMkbdKI59v5b7qicwy8/MSi+wVWEjOmsIKuIlgdw8Zv7ByqSBU
         tkKV1v1Fbr/y+YK7hW5jjbJ3Y0PWbRHZ5alFDL/qfFgWRcIHNAlNM5tV+UginramOs/u
         49V2XsqNhhqhuUOPFEzmvtFopIKwcnzAo5QO90ggTxBp0S8iCH4TUTFpCgZrXwwgFdl4
         ANpNfDPUzYB0XqYxajRVQtBOZKIFNXlqVwzAmkBhEEzDNxa7McSc0tWd0gx3KjVYJZRE
         dM7eK0zU1ImpMnupRIguPGQdpdIM5kepQhtSQK5v0AL5itERiZ7CYjNB/QDRjUZBAcEj
         iHjw==
X-Gm-Message-State: AOJu0YyjrIIIAmlY7crQzg5grXFIK4ZLlwFhkEWcA5cV1h3ajumN4glb
	VUUYClTIl2PZ/ep0SI6PKnocTw==
X-Google-Smtp-Source: AGHT+IGIgmfl8kFxYgfccaUTbjUpz/4MfyDAq2jjgq/Z9YPBa1wYUwZppJ0KQnQ9uo2j2/ApTdwChg==
X-Received: by 2002:a17:906:30c7:b0:9ae:738b:86d0 with SMTP id b7-20020a17090630c700b009ae738b86d0mr1520786ejb.66.1695380817983;
        Fri, 22 Sep 2023 04:06:57 -0700 (PDT)
Received: from cloudflare.com ([2a09:bac5:5064:2dc::49:139])
        by smtp.gmail.com with ESMTPSA id d11-20020a170906370b00b0097404f4a124sm2570971ejc.2.2023.09.22.04.06.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Sep 2023 04:06:57 -0700 (PDT)
References: <20230920232706.498747-1-john.fastabend@gmail.com>
 <20230920232706.498747-4-john.fastabend@gmail.com>
User-agent: mu4e 1.6.10; emacs 28.2
From: Jakub Sitnicki <jakub@cloudflare.com>
To: John Fastabend <john.fastabend@gmail.com>
Cc: daniel@iogearbox.net, ast@kernel.org, andrii@kernel.org,
 bpf@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH bpf 3/3] bpf: sockmap, add tests for MSG_F_PEEK
Date: Fri, 22 Sep 2023 13:06:36 +0200
In-reply-to: <20230920232706.498747-4-john.fastabend@gmail.com>
Message-ID: <875y42sbzj.fsf@cloudflare.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Sep 20, 2023 at 04:27 PM -07, John Fastabend wrote:
> Test that we can read with MSG_F_PEEK and then still get correct number
> of available bytes through FIONREAD. The recv() (without PEEK) then
> returns the bytes as expected. The recv() always worked though because
> it was just the available byte reporting that was broke before latest
> fixes.
>
> Signed-off-by: John Fastabend <john.fastabend@gmail.com>
> ---

Reviewed-by: Jakub Sitnicki <jakub@cloudflare.com>

