Return-Path: <bpf+bounces-55126-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 962CAA788C5
	for <lists+bpf@lfdr.de>; Wed,  2 Apr 2025 09:19:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D6EB13B113D
	for <lists+bpf@lfdr.de>; Wed,  2 Apr 2025 07:18:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C47B231CB0;
	Wed,  2 Apr 2025 07:18:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="AfY1RVlW"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10ADE1E260C
	for <bpf@vger.kernel.org>; Wed,  2 Apr 2025 07:18:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743578320; cv=none; b=S6HZNDdcT8SS/EcaexNXplDWlaPDlCGV7/PV4sVirgK8KndsHRzJMpWZ9Gi7+49iklj7a3ZGPfHUXENx46P3/2L87oHdMLxl6Oe8nxtll+vcZF5T4Xgh21p/QgynIpotrP1HxU0qCpSpYY7iCfpBbZheVczdYRUBzM+el4XcNbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743578320; c=relaxed/simple;
	bh=rjEzmnr1+2wjq2FxTj4ZIbqL36uWLhzyqELF4hjcmb4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tl/ljOeX5xdqQ2e0jqPEvLvf2E9m+hHFYoO7rLYkPZRDDu0Bo5NVRMiPawdyh3iyEvX9AmnjBoKp8VmnOBnX01fmEx0jw2VOZZXZZcA0qGQ0yV8ZCNbDOnRZ6l/ZfyrAB7mspmbPXiUc2iMl+2g0Lm6h867UKDfEou67aAYIl6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=AfY1RVlW; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4394345e4d5so41585835e9.0
        for <bpf@vger.kernel.org>; Wed, 02 Apr 2025 00:18:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1743578316; x=1744183116; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=W0eNMuQ6+Ok777NsoTbkMeCm6WNQ+H1nK9Grprmoglc=;
        b=AfY1RVlW9XQmP7xzI2DNsaWJ45+U8MgmD0aLQcJyZcezFt1PKA0bvc/zAW6yzhpoic
         CzGB5YFyBAexQYzTd/SXfCdJ6XIiTwhFRRIaAHVbb6rrGCxTVw1Cv9HjU5H7x5rAyJ9k
         elC3LgSXMhIpysPT5pIDSdSNLLy+ouP0ZruPayBZq54nLHz9Fnkg/htKDvRZctxUzgRS
         sxrJ/psnN2NGNf8AGr0Pg2hhwyjinIJVaCkUHKe2QlvgXWDzNUZlM1TNiIInFh1yfSgK
         +VcfMK1PJfLr+XvKuyXPywUqQY5BKm5K9bjPV4MTV1Pjn1xs1yA8t1J3HbBk4zg/c7u2
         sl2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743578316; x=1744183116;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W0eNMuQ6+Ok777NsoTbkMeCm6WNQ+H1nK9Grprmoglc=;
        b=AH4Lx5zJT52/EzXZhSEws/5etZWSNApQp9qpZC0y6K2hxL0dBO2gUVx5qj/o4fEQ14
         B2yTygGYLSsUoc0kSp4GKU6v7XzemUC2apFuO7OBggfcA5bJYGYC2k+hz7KVLMqRYmwR
         AKiI+YwkCX7TJPwCjo6SNenfzzq4roi2Ivxkq2QpOzOk+Eg711YxXQe7RS71VhCRE+76
         NFfOvquOrl+xrst2h+YRD49Lj163RYDKEug3PMkLLL6WtglHzzLITPR+1LYgzYfMRlrZ
         ZOHE1ZbwHAh7YzQIhSJ6s6rH2RoK+oSmmCwjQX5KlsnO0p7GE7xlov+4Qv2SUv+FEUde
         n5dg==
X-Forwarded-Encrypted: i=1; AJvYcCX8vfnA7nwN6KQj+psyQSBl2k+YSXAYo2bCEbBOcavRtWMPCO5hZq6NeCtOPHOzvkibA4M=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzyb9WKAf+oKJKjKzUzBbjsbKAyISdLVP2LfvemCg7B/FS/M1O4
	lfDtAkEdUaUxSecBuTydHPZH11Q/Yh5K4+746yvqX6kBntFpKtNYjpsXIgFbnjo=
X-Gm-Gg: ASbGncv5x94qY1xMaSEVLRtg2vutTqCUdojtNOVoaXp0C4Wa1T41DFvNAGtZlXRfJ7J
	ROZaCJ3rddmXDRlincZghIxsZGfwJxl5nPvVConTgvlZldjiTppEoduVCmpXOn/woN9Idw3njbu
	YpBE77vd9JRUNC0VeVJqZU+DvJEiB2YHhhLJazwAxZiEXUwbeafBPUgXS+dEZJHViM8DwA04UFk
	m9zBfYcLn1GBmfKwOJMob/iQMAF5qE1i8thd4z3eI4CKUZmFToIt1L2u/wTRrzBdyLgpgIObvIF
	7yD3EwfSySKFeReQYeOH0qbvzt4RY5Kg+45bmqNGsHkHXVrSbVuU+FvCYAN42maQysuD
X-Google-Smtp-Source: AGHT+IHQ9iNu+elipxYIEZPm2TvVq8PRAYgvNwvPs5tGfD6BvIXUlyeIxgVszh67+jwKs4A4yZZ0tw==
X-Received: by 2002:a05:600c:444b:b0:43d:79:ae1b with SMTP id 5b1f17b1804b1-43eb5c188bemr8972985e9.14.1743578316325;
        Wed, 02 Apr 2025 00:18:36 -0700 (PDT)
Received: from localhost (109-81-92-185.rct.o2.cz. [109.81.92.185])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-39c0b79e393sm16360517f8f.72.2025.04.02.00.18.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Apr 2025 00:18:36 -0700 (PDT)
Date: Wed, 2 Apr 2025 09:18:34 +0200
From: Michal Hocko <mhocko@suse.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Andrii Nakryiko <andrii@kernel.org>, linux-trace-kernel@vger.kernel.org,
	peterz@infradead.org, mingo@kernel.org, bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-team@meta.com, oleg@redhat.com,
	brauner@kernel.org, glider@google.com, mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com, akpm@linux-foundation.org
Subject: Re: [PATCH] exit: add trace_task_exit() tracepoint before
 current->mm is reset
Message-ID: <Z-zkylk6r_rZ5V_K@tiehlicka>
References: <20250401184021.2591443-1-andrii@kernel.org>
 <20250401173249.42d43a28@gandalf.local.home>
 <20250401173416.45a164c8@gandalf.local.home>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250401173416.45a164c8@gandalf.local.home>

On Tue 01-04-25 17:34:16, Steven Rostedt wrote:
> On Tue, 1 Apr 2025 17:32:49 -0400
> Steven Rostedt <rostedt@goodmis.org> wrote:
> 
> > static void exit_mm(void)
> > {
> > 	struct mm_struct *mm = current->mm;
> > 
> > 	exit_mm_release(current, mm);
> > 	trace_exit_mm(mm);
> > 
> > ??
> 
> That should have been:
> 
> static void exit_mm(void)
> {
> 	struct mm_struct *mm = current->mm;
> 
> 	trace_exit_mm(mm);
> 	exit_mm_release(current, mm);

If the primary usecase is to get an overview of the mm before exiting
then this is more appropriate.

-- 
Michal Hocko
SUSE Labs

