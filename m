Return-Path: <bpf+bounces-35995-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 55319940681
	for <lists+bpf@lfdr.de>; Tue, 30 Jul 2024 06:26:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D5FB61F22E8B
	for <lists+bpf@lfdr.de>; Tue, 30 Jul 2024 04:26:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41A1E160796;
	Tue, 30 Jul 2024 04:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="a49/ZVg3"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CACC7C8C0
	for <bpf@vger.kernel.org>; Tue, 30 Jul 2024 04:26:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722313573; cv=none; b=HoT8ioRwVyRUY+6e/RnHzvM53ceW8CgFgnP07p7uHKBR7R3YMKg9E0MDO5L4aFBn5CpdmMv8hnHmxFe05HuMkv+sCYrdJKr2FLA7Ki+EQ/K7/kPcoweEEth1mrxLBIwfLNK+o2FNccVhYGAKy+ypU5fwyNGjVufQ+wMjDoVhHfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722313573; c=relaxed/simple;
	bh=Mtx4KJpatA5SnjkdaCt02hU9bauaRYTl+LYPEglqc20=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HECKEwCABMcDSJovxX5zUdTxkH5Fkbg7GwRM2R57i1ieTsZrHh+svG7ph99jJMSETIm0R7uRRDYA7G1X8lvdlhlzdmVNndYxa1X9CMlBHzg3pa435o/avJHmO8qha5nRJysUYuF+ci7MGP4qN495vMlPMQtRAIbfLdST2tXvpdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=a49/ZVg3; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2ef23d04541so51409811fa.2
        for <bpf@vger.kernel.org>; Mon, 29 Jul 2024 21:26:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1722313570; x=1722918370; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=pSPIujbLoqhDxPLFOPZcqJHOGNFwNiFGR8zNuzloOAs=;
        b=a49/ZVg3/UaHr5BkW/HiznYG8xCB1+kQ6Utx1DT1nFUP4pUT2Bk2i0HzGqIEtKn2B7
         Y8DvNmrYbzZ7oei5vcwHzYWC2w9KwcS3EgQzMicPqLPXON8v2LX3ETky5kFjuQ7nh0mD
         tg25CgVTmFRK0zMoea5dTXLhPnHjGCY41uKCT7nUZJcyNt2IF3BIX+Qm5MPoT+YFPgsL
         MLWziHiVcSITFzh7ANiHxqUeKRTNpQrD6Wx5fJIEMqM0jVL8cvrD+hjWuvJK4JEl+W8W
         QGDx4uggyhoQGUg9TKeXNkblWqcD0I/9Bagd9R6ElEAtEFl+j9jw3RKDULQd/2COrUqA
         660g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722313570; x=1722918370;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pSPIujbLoqhDxPLFOPZcqJHOGNFwNiFGR8zNuzloOAs=;
        b=ZLeVZRkeqXHiSfK+hZEj774G9WS3ebCDDQ5zaQZpqUeza97HI1JgPjvg8FzD6Va3LI
         9mnHpSqtjCHqRbv+MdaJzlvaOartIqdI0alZEpjbHRhLAa0l/SZRM0eS7OkpBIGh5M1X
         J94sAVM8VSZqKvOoBNIIDLOxFr7SR4otRRMpVE5fJc/jV4u2ij/MNXO899Q083A9PwgN
         zlcN6JkgNxHOfeOyb1VBDaLtMebqCtwCCQvvoyeixmuMqs0DoWtYWUGI6f6NjaTvcD7l
         oQW9ufQ6Ucof2PRHQvCzouGUAbNpcN3hpqXvAqVSw3Un+y2pI/PTjTZwhn1EsmKh3itr
         YD4A==
X-Forwarded-Encrypted: i=1; AJvYcCVDq+TQNAlCwILvHccXjdxdJV3+cB/cn7QUa8m3WjIEeOioNUql4XBG6ufMjvdZJVd6QNeA8cWbo8DJf4Cwf8oBEuO1
X-Gm-Message-State: AOJu0Yxp9birUHa7wAS2HG0CwqLZ51NubYmUa+8V6uYEPm0IDVSh1+wP
	MbApJoayjUTBtxnowVcMYOcvCqILTJuuMDbMzrMQGiYSoXW+TzQGGp76WIOvJo0=
X-Google-Smtp-Source: AGHT+IFXbsjffpZdi2unn4HNinuWObp/75AfGTnc0GCTUgc9kJLvpUafB7LyrhY+LA+uMgz8Wa7uMQ==
X-Received: by 2002:a05:651c:a09:b0:2ef:2fc9:c8b2 with SMTP id 38308e7fff4ca-2f12ee422c3mr75754301fa.37.1722313569866;
        Mon, 29 Jul 2024 21:26:09 -0700 (PDT)
Received: from u94a (27-242-33-231.adsl.fetnet.net. [27.242.33.231])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-39ae92434c8sm33256665ab.51.2024.07.29.21.26.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jul 2024 21:26:09 -0700 (PDT)
Date: Tue, 30 Jul 2024 12:25:46 +0800
From: Shung-Hsi Yu <shung-hsi.yu@suse.com>
To: Harishankar Vishwanathan <harishankar.vishwanathan@gmail.com>
Cc: Xu Kuohai <xukuohai@huaweicloud.com>, 
	Eduard Zingerman <eddyz87@gmail.com>, bpf@vger.kernel.org, netdev@vger.kernel.org, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, 
	John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Roberto Sassu <roberto.sassu@huawei.com>, Edward Cree <ecree.xilinx@gmail.com>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Santosh Nagarakatte <santosh.nagarakatte@rutgers.edu>, Srinivas Narayana <srinivas.narayana@rutgers.edu>, 
	Matan Shachnai <m.shachnai@rutgers.edu>
Subject: Re: [RFC bpf-next] bpf, verifier: improve signed ranges inference
 for BPF_AND
Message-ID: <xhc5uslwucbu4233iqszgsj3q4bsu2xtjtrh5qmosqlm72uq52@mhwul4hzgd3p>
References: <20240711113828.3818398-1-xukuohai@huaweicloud.com>
 <20240711113828.3818398-4-xukuohai@huaweicloud.com>
 <phcqmyzeqrsfzy7sb4rwpluc37hxyz7rcajk2bqw6cjk2x7rt5@m2hl6enudv7d>
 <4ff2c89e-0afc-4b17-a86b-7e4971e7df5b@huaweicloud.com>
 <ykuhustu7vt2ilwhl32kj655xfdgdlm2xkl5rff6tw2ycksovp@ss2n4gpjysnw>
 <CAM=Ch06Hps=xv4RmHdWESOjN1pSW2Eo8Xn=qQV+0T9TeNzuPHw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAM=Ch06Hps=xv4RmHdWESOjN1pSW2Eo8Xn=qQV+0T9TeNzuPHw@mail.gmail.com>

Hi Harishankar,

On Sun, Jul 28, 2024 at 06:38:40PM GMT, Harishankar Vishwanathan wrote:
> On Tue, Jul 16, 2024 at 10:52 AM Shung-Hsi Yu <shung-hsi.yu@suse.com> wrote:
> > This commit teach the BPF verifier how to infer signed ranges directly
> > from signed ranges of the operands to prevent verifier rejection, which
> > is needed for the following BPF program's no-alu32 version, as shown by
> > Xu Kuohai:
[...]
> Apologies for the late response and thank you for CCing us Shung-Hsi.
> 
> The patch itself seems well thought out and looks correct. Great work!

Thanks! :)

> We quickly checked your patch using Agni [1], and were not able to find any
> violations. That is, given well-formed register state inputs to
> adjust_scalar_min_max_vals, the new algorithm always produces sound outputs
> for the BPF_AND (both 32/64) instruction.

That is great to hear and really boost the level of confidence. Though I
did made an update[1] to the patch such that implementation of
negative_bit_floor() is change from

	v &= v >> 1;
	v &= v >> 2;
	v &= v >> 4;
	v &= v >> 8;
	v &= v >> 16;
	v &= v >> 32;
	return v;

to one that closer resembles tnum_range()

	u8 bits = fls64(~v); /* find most-significant unset bit */
	u64 delta;

	/* special case, needed because 1ULL << 64 is undefined */
	if (bits > 63)
		return 0;

	delta = (1ULL << bits) - 1;
	return ~delta;

My understanding is that the two implementations should return the same
output for the same input, so overall the deduction remains the same.
And my simpler test with Z3 does not find violation in the new
implementation. But it would be much better if we can have Agni check
the new implementation for violation as well.

Speak of which, would you and others involved in checking this patch be
comfortable with adding a formal acknowledgment[2] for the patch so this
work can be credited in the git repo as well? (i.e. usually replying
with an Acked-by, other alternatives are Reviewed-by and Tested-by)

IMHO the work done here is in the realm of Reviewed-by, but that itself
comes with other implications[3], which may or may not be wanted
depending on individual's circumstances.

I'll probably post the updated patch out next week, changing only the
comments in [1].

> It looks like you already performed tests with Z3, and Eduard performed a
> brute force testing using 6-bit integers. Agni's result stands as an
> additional stronger guarantee because Agni generates SMT formulas directly
> from the C source code of the verifier and checks the correctness in Z3
> without any external library functions, it uses full 64-bit size bitvectors
> in the formulas generated and considers the correctness for 64-bit integer
> inputs, and finally it considers the correctness of the *final* output
> abstract values generated after running update_reg_bounds() and
> reg_bounds_sync().

I had some vague ideas that Agni provides better guarantee, but did not
know exactly what they are. Thanks for the clear explanation on the
additional guarantee Agni provides; its especially assuring to know that
update_reg_bounds() and reg_bounds_sync() have been taken into account.

> Using Agni's encodings we were also quickly able to check the precision of
> the new algorithm. An algorithm is more precise if it produces tighter
> range bounds, while being correct. We are happy to note that the new
> algorithm produces outputs that are at least as precise or more precise
> than the old algorithm, for all well-formed register state inputs.

That is great to hear as well. I really should try Agni myself, hope I
could find time in the near future.

Cheers,
Shung-Hsi

1: https://lore.kernel.org/bpf/20240719081702.137173-1-shung-hsi.yu@suse.com/
2: https://www.kernel.org/doc/html/v6.9/process/submitting-patches.html#when-to-use-acked-by-cc-and-co-developed-by
3: https://www.kernel.org/doc/html/v6.9/process/submitting-patches.html#reviewer-s-statement-of-oversight

