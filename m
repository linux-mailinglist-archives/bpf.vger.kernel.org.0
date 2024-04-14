Return-Path: <bpf+bounces-26722-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 66C3A8A4213
	for <lists+bpf@lfdr.de>; Sun, 14 Apr 2024 13:41:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E8B5AB20D48
	for <lists+bpf@lfdr.de>; Sun, 14 Apr 2024 11:41:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 482E237147;
	Sun, 14 Apr 2024 11:41:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HmZJn/Wy"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56C9623B1;
	Sun, 14 Apr 2024 11:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713094900; cv=none; b=dcAg7rw03RSO0vgsgnVhYbWxdbCVLMvrKRWPMVSfSCIewlM8rAcnqwMRXuHJklvzIM0I+pLyvyqZP19KbmLhAz9Lz6hhPakdXILnwahv4BBNQ3Ll7QfYpsXWVe8XQlk3QLZfp+zV4CjcJAbnHcMEMEeYlFSpy7I6Kv4Vr526ZVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713094900; c=relaxed/simple;
	bh=EZn6yYKuPAbbBUTgvhkM1XRueowJIMNL6Uc2yk7bXLw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YSr1n/G2IKVH1yYDUYDpLm43T5YwiEKZZgn0caGNrgNA+3AkbA09FfWx48eOBOcDAzmTxJjx6NeNCTnkcjd9w+y+4/t3GH/ZjT3yi36DpDp/dCK2fjA9ss5KEnAlCAvPwy9i2b6DtD/7HhC96CaCcqonqLYu34jSQvbg74RzMGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HmZJn/Wy; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-41804f10c68so9589035e9.3;
        Sun, 14 Apr 2024 04:41:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713094897; x=1713699697; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZNPrvH/uFX737faIwrBH9u4ApwKYKRw6XwNvCWgpcCk=;
        b=HmZJn/Wy9napSD2cpFhSIAdGdedHS99fHXsCpQHgHK7LLyF+MFOWYGEZtqcBYJFr1j
         KDYv4YlsF5NsR1gaZkQwj0nnIz15+LnsHpzhLzDjt2z55T6/I40s/z1QoO17REamRpkO
         j6XCHl6jiGk8S9IPcB9cawcM5iQU8zW/dcGEoZ9vrHAchoHVha5XKVOC2LpwXAGHDzlO
         p3qMcuLqPSLnW6oq6jJq8ybNVzc+xpxGXd4sU/WtqFxaVgHQs7tTH2Lqexb3pd//4Emo
         dvgja5tnng6kRL3SqusF/hXjEvNzQdrKYmekMiUIouG7WWE7/i/FF7Z0rxUpm77h9gie
         qRng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713094897; x=1713699697;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZNPrvH/uFX737faIwrBH9u4ApwKYKRw6XwNvCWgpcCk=;
        b=wej5rorZN8CC7bXfVmVXkw42UBKTgg2CG0tN+GftP5s4kDIb+ryCyrUaY8ALKZWW36
         FmZZdwr34/toeFYHM+upUGCTklLRrt9d40X2WsD66LT6qGm8F1P3HP8DkB+dAAyZVGmj
         0aCg+hsdMxNKj1vn/5J8JY6ySpcnXPFQQ7rDte5htUTQsAm09Yec1PqFgYf2tqv6lncx
         9SwihutMDnM0aSnAEa/4YTFWHu51xkVfdO/utdFbSsBBrts+cWvoGpkL1bhh1PzhhsoA
         LOu1dG19rZGDKnya64k2Ub1rP3bQgjbgOUuYE6tt7S//6DQZXYpZW3bqqlx7NfVYQmBE
         1sbg==
X-Forwarded-Encrypted: i=1; AJvYcCVnACq44Y1qphjB/8/An4GEHDWNyMZpHDBx6vRqmo6poS37SZQisZHU1osoXIxM8pKHinpHh4sBAVaoZfdX8A9bst7oir9oqkwRzv1lboLJdaJBu+D950xiuqXfddV9gQV+
X-Gm-Message-State: AOJu0Yz7XBWmXK6Cn0nVHgHVe6seDdMUsiEd6jo3DUtcTrD1XWzKMVjP
	xQX73XmfBRxFM+Gwy/TeGTTm53OhCp8/Knq3D6d928Q/Br5aGSs=
X-Google-Smtp-Source: AGHT+IHs6RhKe0Y4tGvcMZrslfWyJRVTebp0xInWZK0eUAtOK4pAEIxVzZS+wR3KWrQ4pydWlFfcLg==
X-Received: by 2002:a05:600c:4f89:b0:413:f80f:9f9 with SMTP id n9-20020a05600c4f8900b00413f80f09f9mr4984699wmq.25.1713094897423;
        Sun, 14 Apr 2024 04:41:37 -0700 (PDT)
Received: from p183 ([46.53.253.158])
        by smtp.gmail.com with ESMTPSA id ay8-20020a05600c1e0800b004181c91d1dcsm5753154wmb.18.2024.04.14.04.41.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Apr 2024 04:41:36 -0700 (PDT)
Date: Sun, 14 Apr 2024 14:41:34 +0300
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Chaitanya S Prakash <ChaitanyaS.Prakash@arm.com>
Cc: linux-perf-users@vger.kernel.org, anshuman.khandual@arm.com,
	james.clark@arm.com, Josh Poimboeuf <jpoimboe@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Mike Leach <mike.leach@linaro.org>,
	John Garry <john.g.garry@oracle.com>, Will Deacon <will@kernel.org>,
	Leo Yan <leo.yan@linaro.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Chenyuan Mi <cymi20@fudan.edu.cn>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Ravi Bangoria <ravi.bangoria@amd.com>,
	Ahelenia =?utf-8?Q?Ziemia=C5=84ska?= <nabijaczleweli@nabijaczleweli.xyz>,
	Colin Ian King <colin.i.king@gmail.com>,
	Changbin Du <changbin.du@huawei.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
	Tiezhu Yang <yangtiezhu@loongson.cn>,
	Georg =?utf-8?Q?M=C3=BCller?= <georgmueller@gmx.net>,
	Liam Howlett <liam.howlett@oracle.com>, bpf@vger.kernel.org,
	coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2 0/8] perf tools: Fix test "perf probe of function from
 different CU"
Message-ID: <2d7a896b-bbee-4285-9b2b-3edfab6797d3@p183>
References: <20240408062230.1949882-1-ChaitanyaS.Prakash@arm.com>
 <d0dc91b6-98ee-4ddd-b0a9-ba74e1b6c85f@p183>
 <f57685aa-fdbf-4625-900b-d612ffb747f3@arm.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <f57685aa-fdbf-4625-900b-d612ffb747f3@arm.com>

On Thu, Apr 11, 2024 at 05:40:04PM +0530, Chaitanya S Prakash wrote:
> 
> On 4/9/24 11:02, Alexey Dobriyan wrote:
> > On Mon, Apr 08, 2024 at 11:52:22AM +0530, Chaitanya S Prakash wrote:
> > > - Add str_has_suffix() and str_has_prefix() to tools/lib/string.c
> > > - Delete ends_with() and replace its usage with str_has_suffix()
> > > - Delete strstarts() from tools/include/linux/string.h and replace its
> > >    usage with str_has_prefix()
> > It should be the other way: starts_with is normal in userspace.
> > C++, Python, Java, C# all have it. JavaScript too!
> 
> This is done in accordance with Ian's comments on V1 of this patch
> series. Please find the link to the same below.

Yes, but str_has_suffix() doesn't make sense in the wider context.

> https://lore.kernel.org/all/CAP-5=fUFmeoTjLuZTgcaV23iGQU1AdddG+7Rw=d6buMU007+1Q@mail.gmail.com/

	The naming ends_with makes sense but there is also strstarts and
	str_has_prefix, perhaps str_has_suffix would be the most consistent
	and intention revealing name?

