Return-Path: <bpf+bounces-48910-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AAC4A11C1A
	for <lists+bpf@lfdr.de>; Wed, 15 Jan 2025 09:35:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2C17916786B
	for <lists+bpf@lfdr.de>; Wed, 15 Jan 2025 08:35:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B68B1DB13F;
	Wed, 15 Jan 2025 08:35:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="CwYQxqxy"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B7CF23F28E
	for <bpf@vger.kernel.org>; Wed, 15 Jan 2025 08:35:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736930137; cv=none; b=QBxYmpu6YVijIQQ+FbnbPTJ43ulgU6I8pC63kHVjEHq0x+fnez3+xg8lO5T838R2a7u5+nQ3+KU9AcFwS36XeEUySyWiwOca5iCz7Qjt2SqOZEDYKo8+YDdtKBDrTPc+XCAB+f1IHx1Rvs9CnylbesKNDnEBKHsAsmYc9jTB9LY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736930137; c=relaxed/simple;
	bh=2gIseYm5Pj57WexPP3Rw1jQOuq/dpfcgpOlwB79/99k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fytAWxNIMRTMV89i7oznXPljm8FZzMxCuxwfoOcI6Y6waK3jjeGLvgOYVmXl0EIpXFes9GNYLlEl8pLu2eAuNgEvAwToWYBoFpGIQaXMj6KKJ08zHnxodJMY2lrumebWjTOut6Sm47gOrgoSNWDI6sMPKH9AUiAXGNBB+efAePk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=CwYQxqxy; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5da12190e75so631832a12.1
        for <bpf@vger.kernel.org>; Wed, 15 Jan 2025 00:35:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1736930134; x=1737534934; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ohckFtnVSpeCCeKoPpAJ4ruZVbU0fXwtskjaCjfmHjA=;
        b=CwYQxqxyfXpKVVDcmw/xrRVsjRzOfOOW/8KWpOVFs6UhMVaggDTaYjN4SWp2xKCjyJ
         W2cVADClgf+jWKV8w+EHbuXBdJtEONPIAft5xLnYxmAw1fiK+7N+m677MyujPQcCMad1
         pu2P6+LixAS9R4TZK2n+cr2NDrz0YUq4a7QMjGlL47CB3TCSrtPsvHfh88EUIhvWytsi
         vg7WK4tu/trwrWd2Qqly0q3uf9/mtfQ9wz3fmHswE19X2sORtStb4tsQGWps/weDZy3U
         zs+0KRxBxeEQ0371MAgW9mc2smJvh1e/JFzLG84Fi3St7gr9Bot61x9kMVYvWqCly4sF
         CjSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736930134; x=1737534934;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ohckFtnVSpeCCeKoPpAJ4ruZVbU0fXwtskjaCjfmHjA=;
        b=Y9zhhxcQSvlEgUvY80kyDfRbRgaCXcOqtIzgMg4/rJW+dtPZSWY1ngFYrss1h5tpZF
         yeD4CADf2x7bdyyf5rqpJ18iU70RmqRs3wTPA5wR8fP/6yq3n/RogsnlGnv9MZPyIefA
         jzT6IAByE/oQBDT+v1PAuYVGqirIfU3LpUK719YfM3UF8jq7Aq/OWz01Am40zyBvVhM7
         oPgdiqSdASCQ19HafTnBazduMsxHIEQoHAoLr5yJUXC2/0M/DfW0DmDSMMSlXUrQm/bd
         ITOqknHmMchNLG+XdZX8P5OZGUFf9p3GP2ixqn0bL6WnTEeSOn8OP/ckZT8ph7mc9S+s
         HEHg==
X-Gm-Message-State: AOJu0YxbosuFGH6VqCq/+P7LAiHtehUkHJi6twsTuRdMrn/YFXEcR9ku
	Dvwj7t0rMTIYm9vuF9E2agcN50GJNjTF4uWpqdD5ZY4mtjdq94ZK23ZWpTRzZw4=
X-Gm-Gg: ASbGncuYpNlvJvHWSx6Ts1v7V7tjhGvCBk/LtWO5Mmzl6+wS5Mz4/9LtUXdl97mcFHp
	9l7x5aH8tAsQXJAkETZTkliNDpWlSVxtwth6s2yxPjfDSVednIpI1T2voCcoxfDe0X+r4NSmPx5
	k2ycXHwaDCXr1JuORXQ5mST+lf/2IOBT3duUWg2kybu5bJxKERIMZkTuRu5o3sfAM+oPO2/hRoa
	7f9PUResWqvh/rkqK5a249ZzPWwYDVf+s3GcNB+YkVB3UB1dO0NIm/ewvf/5ExxLpn5+Q==
X-Google-Smtp-Source: AGHT+IH1XvUSwlBsKXdAp5KWg/uU35nzOhQAzruJlcZgkjRfjrqnrWD22y+Q3zPdJAsxJsmOfU4B8A==
X-Received: by 2002:a05:6402:2347:b0:5d9:f042:dab with SMTP id 4fb4d7f45d1cf-5d9f0421161mr8073747a12.18.1736930133690;
        Wed, 15 Jan 2025 00:35:33 -0800 (PST)
Received: from localhost (109-81-90-202.rct.o2.cz. [109.81.90.202])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5d9903c4477sm6895267a12.51.2025.01.15.00.35.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jan 2025 00:35:33 -0800 (PST)
Date: Wed, 15 Jan 2025 09:35:32 +0100
From: Michal Hocko <mhocko@suse.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Vlastimil Babka <vbabka@suse.cz>,
	Sebastian Sewior <bigeasy@linutronix.de>,
	Steven Rostedt <rostedt@goodmis.org>, Hou Tao <houtao1@huawei.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Matthew Wilcox <willy@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>, Jann Horn <jannh@google.com>,
	Tejun Heo <tj@kernel.org>, linux-mm <linux-mm@kvack.org>,
	Kernel Team <kernel-team@fb.com>
Subject: Re: [PATCH bpf-next v4 1/6] mm, bpf: Introduce try_alloc_pages() for
 opportunistic page allocation
Message-ID: <Z4dzVO-GBBc6Tr5E@tiehlicka>
References: <20250114021922.92609-1-alexei.starovoitov@gmail.com>
 <20250114021922.92609-2-alexei.starovoitov@gmail.com>
 <Z4Y9BVygLcRTjhMh@tiehlicka>
 <CAADnVQKYb+kHwaAzL5c9S8V+Wcnju+ScMbajmMj2wi6E_=Pq-g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAADnVQKYb+kHwaAzL5c9S8V+Wcnju+ScMbajmMj2wi6E_=Pq-g@mail.gmail.com>

On Tue 14-01-25 17:23:20, Alexei Starovoitov wrote:
> On Tue, Jan 14, 2025 at 2:31 AM Michal Hocko <mhocko@suse.com> wrote:
[...]
> > LGTM, I am not entirely clear on kmsan_alloc_page part though.
> 
> Which part is still confusing?

It is not confusing as much as I have no idea how the kmsan code is
supposed to work. Why do we even need to memset if __GFP_ZERO is used.

-- 
Michal Hocko
SUSE Labs

