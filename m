Return-Path: <bpf+bounces-64895-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F2D5FB184A3
	for <lists+bpf@lfdr.de>; Fri,  1 Aug 2025 17:10:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6D1B91C83AE6
	for <lists+bpf@lfdr.de>; Fri,  1 Aug 2025 15:10:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 309BA27056B;
	Fri,  1 Aug 2025 15:08:52 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from relay.hostedemail.com (smtprelay0017.hostedemail.com [216.40.44.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3DA3271454;
	Fri,  1 Aug 2025 15:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754060931; cv=none; b=hDrub4sNRC0Cg0kqXil03dzUcA8jc1cBgNxwrrmbRjL5pLML+TfFeRoWsV+umxm29nUYPV/H6QSyA1vpx4lSGe2NH679PsSJckv7GkUdFbmbGWqCUDPDOX881PbH0G8j+t1B2EC32/Y4r/7ctHULKEddOvOLyBB7zQe+OGcIYUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754060931; c=relaxed/simple;
	bh=rasj1vF9KNPtkxjQ9MPsKrTo+IxOhyWt5ILF41hd4Lo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=s1OqJiY+P+zTOqivZTtVrWFpqWkfjf6dURHrFR6I3DGdUmIetyeKlfSu7aNHrS/aIlTSgAmCwhRdgjWbVvRTJkNjTP1UrSH5BSdMmRqBCPyg7nYQmqR0sMnw51/6DIeuYdynVG+0/RD9zVdimz9vYsVIamB+1Qv4d5dARdlmV9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf16.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay01.hostedemail.com (Postfix) with ESMTP id 9046F1D92C3;
	Fri,  1 Aug 2025 15:08:48 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf16.hostedemail.com (Postfix) with ESMTPA id 9885020013;
	Fri,  1 Aug 2025 15:08:46 +0000 (UTC)
Date: Fri, 1 Aug 2025 11:09:07 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Yonghong Song <yonghong.song@linux.dev>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 bpf@vger.kernel.org, Douglas Raillard <douglas.raillard@arm.com>
Subject: Re: [PATCH] tracing: Have unsigned int function args displayed as
 hexadecimal
Message-ID: <20250801110907.121f32ee@gandalf.local.home>
In-Reply-To: <9bfa8866-a90f-41bf-8b22-bf704c01a2e5@linux.dev>
References: <20250731193126.2eeb21c6@gandalf.local.home>
	<9bfa8866-a90f-41bf-8b22-bf704c01a2e5@linux.dev>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 9885020013
X-Stat-Signature: yxeho5oa7yktraxxt4cwzyfdippmmrd9
X-Rspamd-Server: rspamout06
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX197pik6S8leMlPpMBdVTeGUNcW1D3B0DGo=
X-HE-Tag: 1754060926-227062
X-HE-Meta: U2FsdGVkX19i9CxOMIycSCcv6gXRkpNZK1ckGg5GGF5Ac/dJ/9t0LY0UbYiGZL4XodtuQAjMgLO8VZChBpHHzgUH+d4LGa3eOEH8jDpGxGRI7q6M2dn493VWq9y5TPjirQl7C7RtMydNNsYLtUIjoqM8Hn1mbEwnkQm7/3gQRGFY8rqb3drpDKUfIHNLLiEVeSzHemyL4ImCJ8jp7QdNI/LUqICuKEH5wVLxNfJX7dE8PBCwVFQQ7MN73ZyrwfClYQrG6oi6VnRJsIKAaeo1kZLV2RYCxjkzsb9UxmgsvBApnPB586wMlMAPieL+KOyR

On Fri, 1 Aug 2025 07:49:53 -0700
Yonghong Song <yonghong.song@linux.dev> wrote:

> > @@ -744,7 +752,14 @@ void print_function_args(struct trace_seq *s, unsigned long *args,
> >   			trace_seq_printf(s, "0x%lx", arg);
> >   			break;
> >   		case BTF_KIND_INT:
> > -			trace_seq_printf(s, "%ld", arg);
> > +			/* Get the INT encodoing */
> > +			int_data = btf_type_int(t);
> > +                        encode = BTF_INT_ENCODING(int_data);  
> 
> See different identation between above 'int_data' and 'encode'. The same as below.

Bah, I think I cut and pasted into emacs and it used spaces instead of tabs.

-- Steve


> 
> > +                        /* Print unsigned ints as hex */
> > +                        if (encode & BTF_INT_SIGNED)
> > +				trace_seq_printf(s, "%ld", arg);
> > +                        else
> > +                                trace_seq_printf(s, "0x%lx", arg);
> >   			break;
> >   		case BTF_KIND_ENUM:
> >   			trace_seq_printf(s, "%ld", arg);  


