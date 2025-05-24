Return-Path: <bpf+bounces-58905-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D12CAC316D
	for <lists+bpf@lfdr.de>; Sat, 24 May 2025 23:09:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DA32217A7EB
	for <lists+bpf@lfdr.de>; Sat, 24 May 2025 21:09:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E80C727C86B;
	Sat, 24 May 2025 21:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jrife-io.20230601.gappssmtp.com header.i=@jrife-io.20230601.gappssmtp.com header.b="vuqPy4Lv"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09E9A1ACEDE
	for <bpf@vger.kernel.org>; Sat, 24 May 2025 21:09:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748120987; cv=none; b=UQC8Lee+ZAd94Nld0SkqlHHcIW3BHjxJRT7lzM2YaIqPQpj2uhqEOqjpTIp76Gt3cS78cs53v6a36AviEJeeXXYhI5Q7GsLkqNcE/Gxr6ztD7zudR4I7EIZOEDPmBUoOkj0inzI2H8Xt7/vOwNGvqZhBxB7T9grD6lz0yniaMQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748120987; c=relaxed/simple;
	bh=6yr+vv4BP6E6vfC4wJQoh0WqQsenxffLcqDp6oNkE58=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KKTtFjba/E/2G0cidcxY68v3RElv18ED/AgwcIPcRi1/pbK5IFwH5FqdW9KdiMJr+YuDb49WlXqQ2UB0wEbnpbyG8tfDaMyAGXlkgXKtauQfZyg0cFqUDfRzNUFrhm2EsLqfa0X7kOU71wfd1iodTjlYT5vyh+BnJBH5Tn015Fw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrife.io; spf=none smtp.mailfrom=jrife.io; dkim=pass (2048-bit key) header.d=jrife-io.20230601.gappssmtp.com header.i=@jrife-io.20230601.gappssmtp.com header.b=vuqPy4Lv; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrife.io
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=jrife.io
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-af5499ca131so96488a12.3
        for <bpf@vger.kernel.org>; Sat, 24 May 2025 14:09:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jrife-io.20230601.gappssmtp.com; s=20230601; t=1748120985; x=1748725785; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3kjjQPL8R/G5b94vrrtD1/jgPBNlugRdUAwJTXFeuoo=;
        b=vuqPy4LvnBXg8uiSfqnRsFMnNpdCikL6OnZInkNKvJIH4obDetNgg5G0VznErPWtEe
         heyfr0mv1HowGK0oYTdgVpmTd2KM9xicY+sYDsvVUp8WlTi6WrxdLNFhyi+O7dPQymyN
         N/5yb6fzT3Hdw5ns5/iSQ1BFyquORBVG0aMqc2xNa+C5FgbVuMjbpCLFkhJZDsMRrAmQ
         AZBFI8OBd0nO+m6JQ8nQql34xkbo2FTloQtCMiz9Am0c4XaMzM0sYcb0Fbswbd72nMb0
         C1O0kQLfZVV4Qs12Q8nKkQOD7AyEOWPTD3/urZVjv9BaGp+MftbBTQaCSr3zipiqDfyY
         dZdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748120985; x=1748725785;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3kjjQPL8R/G5b94vrrtD1/jgPBNlugRdUAwJTXFeuoo=;
        b=LJsFT2xY7VsGUp+YUKJfQqw19qzYw1eLD0DwItkuOr5cCt9IR1CMW9dVOV1V7oWpV4
         PZ3/+aupv0kXQKmqcZ9jc+3CLwQLOL67zS/Iv5zimfrhze2i4vnU3eR+5YfUG2HjY5tz
         fKO/OIzX0bmtRAseKO9GVTwkLSYfS6jJXgIgf8cAKkxFCwFiG68/eMLSBVxVKJ2c4WNF
         6frsp5vRgHtK5exeezYMucjBAxjQvoRf+OQo5rGkGcT5rp/yq388b1fjR+bf5SeHktYD
         eIISnk3+TNwzRoH1g7d63I7dDHoO8AxihlmfXLjAj9Tp44NrhdnO7iCkv5UN/rdC2t5X
         EtgA==
X-Forwarded-Encrypted: i=1; AJvYcCVhQlX6HUsvUJCSovyf7QZoZ0tPSc/Qv5apGS0UVjp46ByTRlnF/9qq9nzh/Xf7DGdflGY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxt40fXlbw+511YOFSgCcwu36gBcq0BwqDDKfK5Py10smDbxv16
	22YpWPdKAuogkbD0l7JlK7w7g9YfUzKDFuiXEbQmSXpCmHuS5FFOcpuRdnXknyUsG31OQbykXhv
	0N7AI0fw=
X-Gm-Gg: ASbGncvpi4WrM+BLuKlzDywV2EbZVa8xrDzko5zoU7aCAZaDQnO7TmynYpNp/gBDjNu
	MVsrBJR+u2MYGWrGODje4Vi9WHVc7QQKoIviWd+CKPG+8DupF7n/UE39tcqpvnFBfq778vEXS4p
	MJsDMUG6MY9CD6/YEMTQMVOspWn6NXkZaFIzEJlZ8JCj/XP2rv0ZRt0S7iRkBWWjD0IwYgRy5Xp
	pMAqxFfMpaW69E5wdqKdAEfycJ67ZwhFCiYeMeaoeANawQNQQ9JLsbBp6cfXj2YnNyoRK8Jblk+
	a4PlYbFFn+UEwZV2RzTbXhElAy0Jxzrruvzt
X-Google-Smtp-Source: AGHT+IHxGV48YIUroKR+UYhiEd7oYVaTUSPn9Z8izK66Bv1kt2jkAksBQkZn9/nnvf/krVylO4oygw==
X-Received: by 2002:a17:903:1b6d:b0:22f:a481:b9d9 with SMTP id d9443c01a7336-23414f6d807mr23105125ad.8.1748120985064;
        Sat, 24 May 2025 14:09:45 -0700 (PDT)
Received: from t14 ([135.180.210.188])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2341f4480e0sm13282765ad.141.2025.05.24.14.09.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 May 2025 14:09:44 -0700 (PDT)
Date: Sat, 24 May 2025 14:09:41 -0700
From: Jordan Rife <jordan@jrife.io>
To: Martin KaFai Lau <martin.lau@linux.dev>
Cc: Kuniyuki Iwashima <kuniyu@amazon.com>, alexei.starovoitov@gmail.com, 
	bpf@vger.kernel.org, daniel@iogearbox.net, netdev@vger.kernel.org, 
	willemdebruijn.kernel@gmail.com
Subject: Re: [PATCH v1 bpf-next 03/10] bpf: tcp: Get rid of st_bucket_done
Message-ID: <bfey2fu3e74d52wjnoimu5ra7wqox2idnc2syzlrvsyjzezdli@lhywkrucesbf>
References: <wxqtnfk2nkwfd3lybyyitawusswohp7hkaoszfxpfdsiuluilr@g3zlc3ojxjkv>
 <20250522204443.78455-1-kuniyu@amazon.com>
 <495201b0-36b9-4a97-8eb3-aedd57e039a9@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <495201b0-36b9-4a97-8eb3-aedd57e039a9@linux.dev>

On Fri, May 23, 2025 at 03:07:32PM -0700, Martin KaFai Lau wrote:
> On 5/22/25 1:42 PM, Kuniyuki Iwashima wrote:
> > From: Jordan Rife <jordan@jrife.io>
> > Date: Thu, 22 May 2025 11:16:13 -0700
> > > > > >   static void bpf_iter_tcp_put_batch(struct bpf_tcp_iter_state *iter)
> > > > > >   {
> > > > > > -	while (iter->cur_sk < iter->end_sk)
> > > > > > -		sock_gen_put(iter->batch[iter->cur_sk++]);
> > > > > > +	unsigned int cur_sk = iter->cur_sk;
> > > > > > +
> > > > > > +	while (cur_sk < iter->end_sk)
> > > > > > +		sock_gen_put(iter->batch[cur_sk++]);
> > > > > 
> > > > > Why is this chunk included in this patch ?
> > > > 
> > > > This should be in patch 5 to keep cur_sk for find_cookie
> > > 
> > > Without this, iter->cur_sk is mutated when iteration stops, and we lose
> > > our place. When iteration resumes and we call bpf_iter_tcp_batch the
> > > iter->cur_sk == iter->end_sk condition will always be true, so we will
> > > skip to the next bucket without seeking to the offset.
> > > 
> > > Before, we relied on st_bucket_done to tell us if we had remaining items
> > > in the current bucket to process but now need to preserve iter->cur_sk
> > > through iterations to make the behavior equivalent to what we had before.
> > 
> > Thanks for explanation, I was confused by calling tcp_seek_last_pos()
> > multiple times, and I think we need to preserve/restore st->offset too
> > in patch 2 and need this change.
> > 
> > diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
> > index ac00015d5e7a..0816f20bfdff 100644
> > --- a/net/ipv4/tcp_ipv4.c
> > +++ b/net/ipv4/tcp_ipv4.c
> > @@ -2791,6 +2791,7 @@ static void *tcp_seek_last_pos(struct seq_file *seq)
> >   			break;
> >   		st->bucket = 0;
> >   		st->state = TCP_SEQ_STATE_ESTABLISHED;
> > +		offset = 0;
> 
> This seems like an existing bug not necessarily related to this set.

Agree that this is more of an existing bug.

> The patch 5 has also removed the tcp_seek_last_pos() dependency, so I think
> it can be a standalone fix on its own.

With the tcp_seq_* ops there are also other corner cases that can lead
to skips, since they rely on st->offset to seek to the last position.

In the scenario described above, sockets disappearing from the last lhash
bucket leads to skipped sockets in the first ehash bucket, but you could
also have a scenario where, for example, the current lhash bucket has 6
sockets, iter->offset is currently 3, 3 sockets disappear from the start
of the current lhash bucket then tcp_seek_last_pos skips the remaining 3
sockets and goes to the next bucket.

I'm not sure it's worth fixing just this one case without also
overhauling the tcp_seq_* logic to prevent these other cases. Otherwise,
it seems more like a Band-aid fix. Perhaps a later series could explore
a more comprehensive solution there.

Jordan

