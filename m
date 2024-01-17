Return-Path: <bpf+bounces-19735-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B938F830776
	for <lists+bpf@lfdr.de>; Wed, 17 Jan 2024 15:02:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D1AA41C2198A
	for <lists+bpf@lfdr.de>; Wed, 17 Jan 2024 14:02:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1887B208A2;
	Wed, 17 Jan 2024 14:02:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XK/WUdrQ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE3DF20310;
	Wed, 17 Jan 2024 14:02:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705500146; cv=none; b=rII5FJbnbXh+vwZ0Gz4xPQ8DvdITFbwH6GwE1QDqnm7aeYqy09btaqgmWZqwPSw4928wCD10b9ZLTyiQDlzsp55e/ax7zkM2grtfAvS5GJFeUAWZav0JDiwTcXQ7vRNyLaNBrkR4SMLNIckHLgzFFlMl2/4M2dCiL+Z9HhQla4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705500146; c=relaxed/simple;
	bh=vtpkyqMtotdPC2V3QrjFzYhU+aMye5ylP4D8sV1rPag=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:Received:From:
	 X-Google-Original-From:Date:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To; b=Y5jsBGo1eJr00CnBBmrvEz3BfUYD5HEFbW30N+GTuPuEo1o0QlBPwOZZ4VDVe7/PglxHdOnGToe7wuY/g7CJ66ao4YtkutsdboLgUpWEZeXCuEfm6YRQ4ccInknPL6fkzDfnb21VKBonEmO/a5ix4IlZKLlR4+cnprLcrWkOlJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XK/WUdrQ; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-50e766937ddso12508282e87.3;
        Wed, 17 Jan 2024 06:02:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705500143; x=1706104943; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rwS+kUbEj1CXgTKMF4Pii0I/Gobr3HpDHcwboK5dbsc=;
        b=XK/WUdrQywnCR4yMVnitdfppyvDvpmGuQchqbbP/I6B/pqFmITsxM1+HXSzzeKVNyY
         Oh9wtE7b1JJbw7SxZx5kFJJybQweonVyW2QSmTmJ4uR8OT3i/c8Z4OfQ8QnummSUiRaq
         Jrj6xbSvULQ+yn/ND1NdSeSMsXB5ErlUdQ8xnCXKzaf1XdGgvZA3mrdUPn2RxD9JEfXv
         30iojob8UkutPw0WCK/OCrdF1TvlAToblcWGR6L4Jo1uY2cMHWXTCxhqpc5obOl6eSiS
         yU/Fy1iuq2jlI6VEF+LPK4A6JIqhu3lkaC4SpSfN4vm71L8u0FAl4MLvFOMYNCBTcVmy
         H8lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705500143; x=1706104943;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rwS+kUbEj1CXgTKMF4Pii0I/Gobr3HpDHcwboK5dbsc=;
        b=wZfAmZnolRoV2tEFldnHg2t2s4k4+YEXh7D5fuiBlDJBMlQkO8miSy+bZN3djypEte
         PshOH/WGHpeQM1RXPHJ/B0BeKG26ps0V8t1zYf75sBBZmsx77ZwEuaZVzJ6PNpOlQFzl
         ZT0LJTPJS9qJ2eiHPMDvo6RxQFa1UjMvNN3l42j+Vsg+OLZwGoptyMnvH5sKn3i1rggs
         dYWwTaykUWa2VsQZqO5aNfrOILjqLZC+pYTW/P9UOo8Bw04z2G2Bf6/jI8IPktg1IhLF
         oeP9BlvcP9i0ixSiYWNniBkevw8LHJNMXm9TJiat8qT81Mbt6opj5o3NrI++haeLLlVG
         vE6w==
X-Gm-Message-State: AOJu0YwnLi19tJcRGCHx02CfBIS94e0g6CG8CA9Q8VZjILUEq8xVYhGF
	172m0jUgU0CSatq97WkI9Mk=
X-Google-Smtp-Source: AGHT+IF/BBzzY9gEnN3f+YYZe5+56B7mSMR+czMogSauXjYzh53Ufl4NGtVeOgr/Ey+baAcGpKwEEQ==
X-Received: by 2002:a05:6512:23aa:b0:50e:ab53:e3ce with SMTP id c42-20020a05651223aa00b0050eab53e3cemr5067948lfv.73.1705500142690;
        Wed, 17 Jan 2024 06:02:22 -0800 (PST)
Received: from krava (2001-1ae9-1c2-4c00-726e-c10f-8833-ff22.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:726e:c10f:8833:ff22])
        by smtp.gmail.com with ESMTPSA id z9-20020a1709060f0900b00a28f6294233sm7792207eji.76.2024.01.17.06.02.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jan 2024 06:02:22 -0800 (PST)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Wed, 17 Jan 2024 15:02:20 +0100
To: David Hildenbrand <david@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	linux-perf-users@vger.kernel.org,
	Ryan Roberts <ryan.roberts@arm.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Oleg Nesterov <oleg@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>, bpf@vger.kernel.org
Subject: Re: [PATCH v1] uprobes: use pagesize-aligned virtual address when
 replacing pages
Message-ID: <Zafd7FkFdts6Ikp-@krava>
References: <20240115100731.91007-1-david@redhat.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240115100731.91007-1-david@redhat.com>

cc-ing bpf list

jirka

On Mon, Jan 15, 2024 at 11:07:31AM +0100, David Hildenbrand wrote:
> uprobes passes an unaligned page mapping address to
> folio_add_new_anon_rmap(), which ends up triggering a VM_BUG_ON() we
> recently extended in commit 372cbd4d5a066 ("mm: non-pmd-mappable, large
> folios for folio_add_new_anon_rmap()").
> 
> Arguably, this is uprobes code doing something wrong; however,
> for the time being it would have likely worked in rmap code because
> __folio_set_anon() would set folio->index to the same value.
> 
> Looking at __replace_page(), we'd also pass slightly wrong values to
> mmu_notifier_range_init(), page_vma_mapped_walk(), flush_cache_page(),
> ptep_clear_flush() and set_pte_at_notify(). I suspect most of them are
> fine, but let's just mark the introducing commit as the one needed
> fixing. I don't think CC stable is warranted.
> 
> We'll add more sanity checks in rmap code separately, to make sure that
> we always get properly aligned addresses.
> 
> Reported-by: Jiri Olsa <jolsa@kernel.org>
> Closes: https://lkml.kernel.org/r/ZaMR2EWN-HvlCfUl@krava
> Fixes: c517ee744b96 ("uprobes: __replace_page() should not use page_address_in_vma()")
> Tested-by: Jiri Olsa <jolsa@kernel.org>
> Reviewed-by: Ryan Roberts <ryan.roberts@arm.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Oleg Nesterov <oleg@redhat.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Alexander Shishkin
> Cc: Jiri Olsa <jolsa@kernel.org>
> Cc: Namhyung Kim <namhyung@kernel.org>
> Cc: Ian Rogers <irogers@google.com>
> Cc: Adrian Hunter <adrian.hunter@intel.com>
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  kernel/events/uprobes.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
> index 485bb0389b488..929e98c629652 100644
> --- a/kernel/events/uprobes.c
> +++ b/kernel/events/uprobes.c
> @@ -537,7 +537,7 @@ int uprobe_write_opcode(struct arch_uprobe *auprobe, struct mm_struct *mm,
>  		}
>  	}
>  
> -	ret = __replace_page(vma, vaddr, old_page, new_page);
> +	ret = __replace_page(vma, vaddr & PAGE_MASK, old_page, new_page);
>  	if (new_page)
>  		put_page(new_page);
>  put_old:
> -- 
> 2.43.0
> 
> 

