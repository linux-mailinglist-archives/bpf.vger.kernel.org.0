Return-Path: <bpf+bounces-58887-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B766AC2CE5
	for <lists+bpf@lfdr.de>; Sat, 24 May 2025 03:25:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2AF7B4A7441
	for <lists+bpf@lfdr.de>; Sat, 24 May 2025 01:25:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB1581E2606;
	Sat, 24 May 2025 01:24:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jrife-io.20230601.gappssmtp.com header.i=@jrife-io.20230601.gappssmtp.com header.b="aaU3PFa+"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7A161DF987
	for <bpf@vger.kernel.org>; Sat, 24 May 2025 01:24:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748049897; cv=none; b=sjdJINLkf8EDNG1C+ztzsoOJTcisB6/o6fa68Q2ka1RVDKUxxS1g/4z0YSgUihTu3MevE3eRjrub6CQhiwntwLPqAGYaBl3IYL/Ks6I0D2zks1XxbrL7JSR/EnkDqnH676SPNTrdUTjQ/NEp/VVSRh7IQjTtq+AvtpywzmrdcdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748049897; c=relaxed/simple;
	bh=JlNKQSYJeweRVq8pXvJaYnPt7vQT0Na2CL0+Bdazonk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JJnuYyAFOPBZLprNy9EM1Z9jm1Rmg1krsztYsmbckf026jruW28oNePsVC8KeEpEfgytJp4iigXcXAsSMm83cTLHM3SIyVAovRRPegYczr8DSzZq7Xaig1vT5mZipIn/3eFpLaYNcxE3YDvL9ysVLebyqkDuIJYwwZNY4e2ONEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrife.io; spf=none smtp.mailfrom=jrife.io; dkim=pass (2048-bit key) header.d=jrife-io.20230601.gappssmtp.com header.i=@jrife-io.20230601.gappssmtp.com header.b=aaU3PFa+; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrife.io
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=jrife.io
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-30e7d9e9a47so88396a91.3
        for <bpf@vger.kernel.org>; Fri, 23 May 2025 18:24:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jrife-io.20230601.gappssmtp.com; s=20230601; t=1748049895; x=1748654695; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Qq13+igEMhsgxpMLdog5ck2P8KdfF5zkUseHq2QAlyU=;
        b=aaU3PFa+zytY1TvN91qeekYM5Ymut80Bf4IVoqVUW9fKCK4Q5hRa68otg8O2BVsp0i
         6DMNNoO+lbT5/jT4nd/dkMuvtW4T8d0gZNm+4v0jukH48SOK+PC7h+uACFHaL4HNPF+o
         XZiOjLNqBql9GDe1DLghKJgXqZGkHThMHi10ZyKg68xrxiYIVTdt2vJckInvE2Sy+l0B
         9SDsSr98h1AKTiYGzVUf9J6+0XdvKN6jXj9unvSijeA3JN9cJlnGJaAc+VbeOV78xWkj
         Bsm4zqEzcoU8UVCYnAQT11gsAwLj932GnQvb4zlp/0wwxTglH0o78MwN8iXQPHrovhRr
         /Dww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748049895; x=1748654695;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Qq13+igEMhsgxpMLdog5ck2P8KdfF5zkUseHq2QAlyU=;
        b=G+fhg/UD2vWUgc28SfnIdSkMIKE8NFEuaVMoj71vjhyPaqjnLrXbh0PQo3z/C7j5Py
         vFNR9/Dxo/3EPxgKRHD4TqsTsPCQUHMfBHfJc19Hp1As8kaN4o/dr4XQrngEY8dVk9hJ
         Qh6P7NfXZs7IdDJrqDUGCyZ/J4+XUWji6c7Q4RycrFGKLNhYchwDd0Jq+vcjrxQoJhCC
         QtznDtDvYb7RSsXkhLHj50a9V8sEofttwujNSS2IfcEXLlIGMizoplLhc8N+R9iueU99
         4eUJV9RdIlQ63kOgfrl7OygAMTz++D8/kOuHPMBPm8nuxmVg8sBUsFZ8TYAF4+/N/NZU
         +e3Q==
X-Forwarded-Encrypted: i=1; AJvYcCWzcuAbmdkPnXJvSwZ62OEhPoRkEo2v6Ah/nBGexEm78Gs9UWL/4vTyw0jAnQB8fUa1K6E=@vger.kernel.org
X-Gm-Message-State: AOJu0YxP7KNcFsa9w9bx2sm1FqUZGymJvaCJ61G0IuALhQ1Px+jvxk0P
	9tF4V/vc+JyUiX2aBaShzUaoDNn0UCTt1ClNoyX+1F2b5UQ0xT2iq6RJZxw/o69+lbM=
X-Gm-Gg: ASbGncvfDMjUamMoWva8zmomsDsmnoXjqMJFE2eSJVLQ9Q5kKuMAKkSG77fVxEQ0qnm
	9i1AD+DyjhrnIYCsmOMUXoFkvvbKQx9prBlCKhOwH6my4xbgzJN8DVEcFbEZ6NKKPI8ZjWRUVxA
	vzqxBxDqMlZPEQg5k0wy//Ksl5iqB/+L438zZbfbgGsmgXaZslF3YJfB+VCaXxBAnKhK5BaaGD/
	GU0W1JfH483tNnpeJzweLO7LsWYCC/4Lrq2F7q+5uEOfK1TGDeWfbX3v1P4xEseXkboByDGDBj2
	LZJ6fsWqFiKCDMhJnx2+7sP51cCPiGRblYct0Ys/dE5hH15/
X-Google-Smtp-Source: AGHT+IF6WqCkeKTcmgjh1qJPsba0drc2G/bZjDpfP3R9aibTzLRrdZlX5RQ7FjpbI6Knr5PZzA6G6g==
X-Received: by 2002:a17:90b:4c0e:b0:310:ce23:a078 with SMTP id 98e67ed59e1d1-311106afdf9mr594831a91.7.1748049894796;
        Fri, 23 May 2025 18:24:54 -0700 (PDT)
Received: from t14 ([2001:5a8:4528:b100:ff7f:ad48:17ea:17bb])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-310f885511asm1195466a91.22.2025.05.23.18.24.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 May 2025 18:24:54 -0700 (PDT)
Date: Fri, 23 May 2025 18:24:52 -0700
From: Jordan Rife <jordan@jrife.io>
To: Martin KaFai Lau <martin.lau@linux.dev>
Cc: Daniel Borkmann <daniel@iogearbox.net>, 
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>, Kuniyuki Iwashima <kuniyu@amazon.com>, 
	Alexei Starovoitov <alexei.starovoitov@gmail.com>, netdev@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH v1 bpf-next 05/10] bpf: tcp: Avoid socket skips and
 repeats during iteration
Message-ID: <mfrii5tn6wj4bskpoewzsmqmhyc47s5343qrhpq7sdotr54zoe@3kpggsqe4cxi>
References: <20250520145059.1773738-1-jordan@jrife.io>
 <20250520145059.1773738-6-jordan@jrife.io>
 <2e350e8b-3192-48e9-a419-ba727a52abee@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2e350e8b-3192-48e9-a419-ba727a52abee@linux.dev>

> > +static struct sock *bpf_iter_tcp_resume_listening(struct seq_file *seq)
> > +{
> > +	struct inet_hashinfo *hinfo = seq_file_net(seq)->ipv4.tcp_death_row.hashinfo;
> > +	struct bpf_tcp_iter_state *iter = seq->private;
> > +	struct tcp_iter_state *st = &iter->state;
> > +	unsigned int find_cookie = iter->cur_sk;
> > +	unsigned int end_cookie = iter->end_sk;
> > +	int resume_bucket = st->bucket;
> > +	struct sock *sk;
> > +
> > +	sk = listening_get_first(seq);
> 
> Since it does not advance the sk->bucket++ now, it will still scan until the
> first seq_sk_match()?

Yeah, true. It will waste some time in the current bucket to find the
first match even if iter->cur_sk == iter->end_sk.

> Does it make sense to advance the st->bucket++ in the bpf_iter_tcp_seq_next
> and bpf_iter_tcp_seq_stop?

It seems like this should work. If you're on the last listening bucket
and do st->bucket++ on stop/next, the next call to listening_get_first()
will just return NULL then fall through to the established buckets in
bpf_iter_tcp_resume(). Will need to think through the edge cases a bit
more...

> > +static struct sock *bpf_iter_tcp_resume(struct seq_file *seq)
> > +{
> > +	struct inet_hashinfo *hinfo = seq_file_net(seq)->ipv4.tcp_death_row.hashinfo;
> > +	struct bpf_tcp_iter_state *iter = seq->private;
> > +	struct tcp_iter_state *st = &iter->state;
> > +	struct sock *sk = NULL;
> > +
> > +	switch (st->state) {
> > +	case TCP_SEQ_STATE_LISTENING:
> > +		if (st->bucket > hinfo->lhash2_mask)
> 
> Understood that this is borrowed from the existing tcp_seek_last_pos().
> 
> I wonder if this case would ever be hit. If it is not, may be avoid adding
> it to this new resume function?

Yeah, I think we should be able to get rid of this.
bpf_iter_tcp_resume_listening and bpf_iter_tcp_resume_established should
just fall through and return NULL anyway in these cases.

Jordan

