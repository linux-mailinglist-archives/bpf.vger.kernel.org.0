Return-Path: <bpf+bounces-57285-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E282FAA7AFA
	for <lists+bpf@lfdr.de>; Fri,  2 May 2025 22:39:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 439F47AA2D6
	for <lists+bpf@lfdr.de>; Fri,  2 May 2025 20:38:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35CB01FBC90;
	Fri,  2 May 2025 20:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YhEtOdnV"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FBFB42A87;
	Fri,  2 May 2025 20:39:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746218352; cv=none; b=aygqdAEI+ixIC43oNOytq1JSclfujmNkoTSQrxeW6YzyzZW3wXrBqSnP+76OQ/rJiK/vLHeaSa9NtkB08aT0IRfM5Y0ZA998mloktkLvbTxXWhFnG1BPmcXMDSi5cw+wDeC35uPEWskcdUmNJ3R3VeXsGFl7UXU3yafounAURDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746218352; c=relaxed/simple;
	bh=mC6wWHTE9kA9KjUHJt89lPkMmrC9D8rcD91mVEwMFg0=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JYcM9jX4+WUMqV4IFuGlnxkYKuY1SWNBk0T4Hfp8T6b6p/pmIVN+ApLotm2ajtYGnqZ86bseliyISlRG0S5+VWEMnupNQsCndXb7UdXlLIkm6U9AUxkfwIDMkMtyq3BGGrou1NX/2ACVGGzuGZzPr8xW98B9KTnfAmkhm99Hm94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YhEtOdnV; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-22423adf751so30631265ad.2;
        Fri, 02 May 2025 13:39:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746218350; x=1746823150; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8z3EqYcsGR+MlwLPd6CssGqOcAitR+EUhBxjEUIwY2Y=;
        b=YhEtOdnVYCxKtwUi0Kd16EDridlXCZxSo434c+SXn4cjZdtRG4+SzQK/uTnZBWA7Rg
         a/YXxAeFygLBp+IlDTpaCyMAH77+lBS5LogFQ4L6MwAsMnRQcSya5iK/PG+Y5JhP7Qef
         ddgREaahYTrnNoNlDDZXTjtsn6xgh1NK5Exm7OHDFE2yhEMN26YH2MfmdG4Xpw6Voaf8
         40NVqxTJwX6kJHNILHVN85GnqVysNQjdoSooT19a5GqYX9u1fKAT8WB2OF6p96PSesUy
         pZlUPqWc5LpotpeUrPj85BywWebEjrywZziC7X+AEbMtngzzse0CbhwtrZwd3zFlqmGE
         T82A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746218350; x=1746823150;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8z3EqYcsGR+MlwLPd6CssGqOcAitR+EUhBxjEUIwY2Y=;
        b=haR0NdImp1ieQCxKhJjPqKNo/k+VWYr191W3qK3cWme0tiOxbBKq05ajxVKYtAUiDp
         wVqPeLRi8i1o7fse9LSLugCfGV3kwSChQxvUiVuuztVdM5VFTlWgogmbJtwJuyuK9lFw
         pSRfb9bMldtmBiVeqgINfh2ulnnK7T267Wld8SdgvuboKO1GD6AtJlMVUBy5bZo7h7Yt
         hZwvEol/dggTlgfEyjjZEw8hyfLxpdMbELBEsDvfpuRDBLZbauTLoPF8SJB7VpjGn9BW
         vlbrOBFPpK7kbmGZZnvMFm9DW47EFUCorq0Ji9QMx/pzjjjvOX2hpVJUCmX91pRQCahb
         cVCQ==
X-Forwarded-Encrypted: i=1; AJvYcCUsoHoc7hMKm+b1qwO6O2DcK3gzm+fU+nq8J4CKkvvn1kT9IqFQBf7Z9k0sB+bZ2WE4cR0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxmqNj3AN4kAk2gOGchFZfe5hDZgWCyiusT1gbeFaAmX025KY59
	kL8B/f5CoAbgpfru7nkXuRUjDFWlSAjOD7SR1u2n+qArhhKDv2u/c54HHQ==
X-Gm-Gg: ASbGnctpNgM8/BmnqQXbZWZVEXUDDkCIdt/lcirYzyrhpPdxZKFfIpa/Awc//wDHs4h
	sNyy/t6LarWlN6b4pA/PCCoLxJIYDvEfal6jkXAhVQygZpZGyjkSVVRmxZUJ9Ry+itn5eykluNG
	LFdVsYddWdaDCULc7gBP7a5oxxzHIEe5CFJ2y3UIjA97D7pYFhrvjr4JImlsYJDoxpOeeXcSW2r
	Tfb/zxelmZxwuuPb5RiO7CqrZxdqry3JXZdjemKQV799tH6ptll0QuCrPi7GJWFzkDRlM85RdFL
	uVLoBqrIMr/cexJ89Wz6q7dAAB//ZufhThzsWiOFWja+QRfpxPIbdHwzfDiPgPVPEaHQ7K/rTgo
	lIXkQPtk=
X-Google-Smtp-Source: AGHT+IHniOfOSqTOmPAS7DiJOHlNwUmqf0kAdZOQBzBUu02x64sF946oV7HZy1W33fp2frTy3yO35w==
X-Received: by 2002:a17:903:2405:b0:215:4a4e:9262 with SMTP id d9443c01a7336-22e102b84cbmr61883965ad.8.1746218350368;
        Fri, 02 May 2025 13:39:10 -0700 (PDT)
Received: from kodidev-ubuntu (69-172-146-21.cable.teksavvy.com. [69.172.146.21])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22e1521fc03sm12066605ad.157.2025.05.02.13.39.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 May 2025 13:39:10 -0700 (PDT)
From: Tony Ambardar <tony.ambardar@gmail.com>
X-Google-Original-From: Tony Ambardar <Tony.Ambardar@gmail.com>
Date: Fri, 2 May 2025 13:39:07 -0700
To: Alan Maguire <alan.maguire@oracle.com>
Cc: dwarves@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: BUG in pahole?: strange error in tests/flexible_arrays.sh
Message-ID: <aBUta5R8y+OX6sKB@kodidev-ubuntu>
References: <aBQwRduNwBFciGkq@kodidev-ubuntu>
 <3b19f6a5-a5f5-4872-b38d-018165b5edd7@oracle.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3b19f6a5-a5f5-4872-b38d-018165b5edd7@oracle.com>

On Fri, May 02, 2025 at 09:18:56AM +0100, Alan Maguire wrote:
> On 02/05/2025 03:39, Tony Ambardar wrote:
> > Hello all,
> > 
> > I ran into the following running the latest pahole tests:
> > 
> >   $ vmlinux=~/linux/vmlinux ./tests/tests
> >     1: Validation of BTF encoding of functions; this may take some time: Ok
> >     2: Default BTF on a system without BTF: Ok
> >     3: Flexible arrays accounting: pahole: type 'bpf_empty_prog_array' not found
> >   pahole: type 'kstatmount' not found
> >   pahole: type 'crypto_lskcipher' not found
> >   pahole: type 'crypto_sig' not found
> >   pahole: type 'hash_ctx' not found
> >   pahole: type 'scsi_stream_status_header' not found
> >   pahole: type 'virtnet_info' not found
> >   pahole: type 'geneve_dev' not found
> >   pahole: type 'geneve_config' not found
> >   pahole: type 'lirc_fh' not found
> >   pahole: type 'scmi_registered_events_desc' not found
> >   pahole: type 'events_queue' not found
> >   pahole: type 'hid_debug_list' not found
> >   pahole: type 'flow_offload_action' not found
> >   pahole: type 'nft_rule_dp_last' not found
> >   pahole: type 'nft_rhash_elem' not found
> >   pahole: type 'nft_hash_elem' not found
> >   pahole: type 'nft_bitmap_elem' not found
> >   pahole: type 'nft_rbtree_elem' not found
> >   pahole: type 'nft_pipapo_elem' not found
> >   pahole: type 'xt_standard_target' not found
> >   pahole: type 'xt_error_target' not found
> >   pahole: type 'ipt_standard' not found
> >   pahole: type 'ipt_error' not found
> >   pahole: type 'ip6t_standard' not found
> >   pahole: type 'ip6t_error' not found
> > 
> > This is simple to reproduce (e.g. code in flexible_arrays.sh):
> > 
> >   $ pahole kstatmount ~/linux/vmlinux
> >   pahole: type 'kstatmount' not found
> > 
> > But despite the above:
> > 
> >   $ bpftool btf dump file ~/linux/vmlinux format raw|grep kstatmount
> >   [13145] STRUCT 'kstatmount' size=624 vlen=8
> > 
> > And:
> >   
> >   $ pahole -C kstatmount ~/linux/vmlinux
> >   struct kstatmount {
> >           struct statmount *         buf;                  /*     0     4 */
> >   ...
> >   };
> > 
> > Has this been seen before? Am I missing something? Any insight folks have
> > would be appreciated.
> > 
> > The same behaviour is also seen with '.tmp_vmlinux1.btf.o', which I attach.
> > 
> > Many thanks,
> > Tony Ambardar
> 
> hi Tony, I've seen this too (with a slightly different cast of
> characters); I keep meaning to look into it but haven't had a chance yet
> so thanks for doing some investigation! Seems like it is a bug in type
> display rather than in BTF generation at least..
> 
> Alan

Thanks for confirming this -- I was worried it might be a side-effect of
my function-encoding patch. Out of curiosity, how does option "-C" affect
BTF parsing or pahole operation? It wasn't clear to me just what "Show
just this class" means/implies...

Cheers,
Tony

