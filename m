Return-Path: <bpf+bounces-43235-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 94C969B1925
	for <lists+bpf@lfdr.de>; Sat, 26 Oct 2024 17:33:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4AED8B218E6
	for <lists+bpf@lfdr.de>; Sat, 26 Oct 2024 15:33:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5538270822;
	Sat, 26 Oct 2024 15:33:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L8iGzpVJ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD5A325762;
	Sat, 26 Oct 2024 15:33:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729956816; cv=none; b=M5dcmpCrCCf5RBEC4hCKayE0QDk7/e/UCV7zMYpwAvUsZjUrm3RNX2HiVjVxESb1DTUfk/xQah88vVeiSYxNJoioX1HmCFbfRoJk++tK+QJBYxhIIw8mVmeItcXyq34sEMpzGgepOzEdWkW+583l9yEfbLp+nVyqWKLlbf9bOPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729956816; c=relaxed/simple;
	bh=FSLsp2sahx8qchsENuYWxME34+U+ngpL3LY6oAgQK4s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JkY0v/etGGJSvwyf4pY7MPwXSuzPRAd8P21ltDL32qVAAU03fNKu6SIaRgytS3zU6RJGEQ0HNG8pjCufn9/Fm7vNPEPL6aVGWVVqIEDwyzWRsUGLkKgvoUuK26OceERqRwAfvoS/TnAUy+oAdqzcf6itSvd0LFvySGg3MzaXdXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L8iGzpVJ; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-20cf6eea3c0so24354575ad.0;
        Sat, 26 Oct 2024 08:33:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729956813; x=1730561613; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=TYN2F/a1w4I8r5R0a7C5YTvUd+uTQUcH+unfZ/kP0o8=;
        b=L8iGzpVJFAqa4uG5gCL6tA2zCtV4kNXDyCFuBvHAQM66eZupK+cR/Fwv6NAfvwwoZ7
         Ma+VTmR5jEytj5+ioScAXkjTj9ewmC9S7mYQgPTxX/g25BuIkr6O3nt5Avf6Tgyv+WJQ
         HYEshURz5MmBpx0HCG2SYrnwpXCcaHH4OmE0/okFtTFYugNAii0I+bjVu1KZH7wtc2/1
         wNY4czUNxQYh0O/Bqs+UsXJ9eC2tRjYdJqLVXfwR0iWwvlo8J+vrzZS7OUDavcyyahDx
         KFkdS0f4WdDHh+UIBSFCq1BI+OJqA+ztRnQqGxlXX46eo8M9T84URYP90N7xT+rhLATh
         6nvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729956813; x=1730561613;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TYN2F/a1w4I8r5R0a7C5YTvUd+uTQUcH+unfZ/kP0o8=;
        b=w60llEMWTBUA+Cdh6gvEln5UwmL6zDkRKP+ExHSLTprLua2PD98iaYzID0Qh0kZsUZ
         BQ+uNnOWfgVhB+dhECE8P/flRaRizA9hK6BPoVnkKVLiYCf/0YbO2y/hoGDtB5Ulhho/
         6+5ieja3EP66zwqXkV56nrzzqx7SIdF4utH8wwDF/EDY3lA9tPPeKnWsBrPipzm+mMI6
         NrIyXZnR9pyWDooBesKjjpfdrH7Yb6UvbPrZhNXQtK5UOw08Ap3rQYRReAbkuVt4ahFk
         PjRN6TEbmoq1POrkL8/GyO0Gju6kO9QXz4ZTalddbWrNAqbzTtuVqsS3WKGWqS/MYYat
         +V3g==
X-Forwarded-Encrypted: i=1; AJvYcCVTzOdOH54akBEhjxndy29tp8FubOHUUEQkkpzTujMH2siQc9pdOV6L04Sa7+kpJS72I8M=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZANtcYw3fa3+PrfWCyvH9DXEGsJ1XxAm8SQHRbZkHcwxF+E/z
	9CSwrT88oYVuunT6NP+aphHv7bgPKo8CG0Wv5IguaDk1wZg3GKQu
X-Google-Smtp-Source: AGHT+IEs4+UY+gR5MmyNlRUM45535Mzth7SzrVKuHFqHOstxU1fqKPHB7JCpyrOc0epukJqcLvgnWQ==
X-Received: by 2002:a17:903:40c8:b0:20d:cb6:11e with SMTP id d9443c01a7336-210c68dd576mr37573765ad.26.1729956813020;
        Sat, 26 Oct 2024 08:33:33 -0700 (PDT)
Received: from localhost ([2601:647:6881:9060:6a46:a288:5839:361d])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-210bbf434bcsm25541015ad.20.2024.10.26.08.33.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Oct 2024 08:33:32 -0700 (PDT)
Date: Sat, 26 Oct 2024 08:33:31 -0700
From: Cong Wang <xiyou.wangcong@gmail.com>
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, john.fastabend@gmail.com,
	Cong Wang <cong.wang@bytedance.com>, zijianzhang@bytedance.com
Subject: Re: [Patch bpf] bpf: check negative offsets in __bpf_skb_min_len()
Message-ID: <Zx0LyxWQThUCIwnq@pop-os.localdomain>
References: <20241008053350.123205-1-xiyou.wangcong@gmail.com>
 <de2e0d8e-e7eb-4cbd-9397-29ddc79f1961@iogearbox.net>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <de2e0d8e-e7eb-4cbd-9397-29ddc79f1961@iogearbox.net>

On Tue, Oct 22, 2024 at 10:52:31PM +0200, Daniel Borkmann wrote:
> On 10/8/24 7:33 AM, Cong Wang wrote:
> > From: Cong Wang <cong.wang@bytedance.com>
> > 
> > skb_transport_offset() and skb_transport_offset() can be negative when
> 
> nit: I presume the 2nd one is skb_network_offset?
> 
> > they are called after we pull the transport header, for example, when
> > we use eBPF sockmap (aka at the point of ->sk_data_ready()).
> > 
> > __bpf_skb_min_len() uses an unsigned int to get these offsets, this
> > leads to a very large number which causes bpf_skb_change_tail() failed
> > unexpectedly.
> > 
> > Fix this by using a signed int to get these offsets and test them
> > against zero.
> > 
> > Fixes: 5293efe62df8 ("bpf: add bpf_skb_change_tail helper")
> > Cc: Daniel Borkmann <daniel@iogearbox.net>
> > Signed-off-by: Cong Wang <cong.wang@bytedance.com>
> 
> Is there any chance you could also extend the sockmap BPF selftest with
> this case you're hitting so that BPF CI can run this regularly?

Yes, my colleague Zijian (Cc'ed) is working on a selftest to cover this case.

Please let me know if you prefer to send it together with the selftest,
technically it would make backporting this fix harder, but I am open to
any suggestion here.

> 
> > ---
> >   net/core/filter.c | 21 +++++++++++++++------
> >   1 file changed, 15 insertions(+), 6 deletions(-)
> > 
> > diff --git a/net/core/filter.c b/net/core/filter.c
> > index 4e3f42cc6611..10ef27639a5d 100644
> > --- a/net/core/filter.c
> > +++ b/net/core/filter.c
> > @@ -3737,13 +3737,22 @@ static const struct bpf_func_proto bpf_skb_adjust_room_proto = {
> >   static u32 __bpf_skb_min_len(const struct sk_buff *skb)
> >   {
> > -	u32 min_len = skb_network_offset(skb);
> > +	int offset = skb_network_offset(skb);
> > +	u32 min_len = 0;
> > -	if (skb_transport_header_was_set(skb))
> > -		min_len = skb_transport_offset(skb);
> > -	if (skb->ip_summed == CHECKSUM_PARTIAL)
> > -		min_len = skb_checksum_start_offset(skb) +
> > -			  skb->csum_offset + sizeof(__sum16);
> > +	if (offset > 0)
> > +		min_len = offset;
> > +	if (skb_transport_header_was_set(skb)) {
> > +		offset = skb_transport_offset(skb);
> > +		if (offset > 0)
> > +			min_len = offset;
> > +	}
> > +	if (skb->ip_summed == CHECKSUM_PARTIAL) {
> > +		offset = skb_checksum_start_offset(skb) +
> > +			 skb->csum_offset + sizeof(__sum16);
> > +		if (offset > 0)
> > +			min_len = offset;
> > +	}
> >   	return min_len;
> 
> I'll let John chime in, but does this mean in case of sockmap min_len always ends
> up at 0? I just wonder whether we should pass a custom __bpf_skb_min_len to
> __bpf_skb_change_tail for bpf_skb_change_tail vs sk_skb_change_tail assuming the
> compiler is able to inlining all this (instead of indirect call).

Yes, in case of sockmap skb->data is already past TCP header, so all the
offsets here are negative. And since the 'new_len' of bpf_skb_change_tail()
is unsigned (too late to change), min_len should be zero.

Thanks.

