Return-Path: <bpf+bounces-28573-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A58458BBB31
	for <lists+bpf@lfdr.de>; Sat,  4 May 2024 14:22:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3063A1F2202D
	for <lists+bpf@lfdr.de>; Sat,  4 May 2024 12:22:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 724892232B;
	Sat,  4 May 2024 12:22:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="msNTUbni"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38811F513
	for <bpf@vger.kernel.org>; Sat,  4 May 2024 12:22:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714825349; cv=none; b=qYVAh+Z32JTfPKu5yJ1FcZ/5OnnsbWZ86VmiMegZqA6T+DUVNbpf5oi34I94he4U/BbKYldDyxKqgWlyuN0qf1jbpCCzdxtfQEHY9mBHh7DiJ/+DieKp1IltNBhO1+gbp9HRYbwp9Z1OmbsLe8hSfya2CDnNN2yUlD0E4dWZ3aI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714825349; c=relaxed/simple;
	bh=GRHxUCqGaZoAecd6ElsSHObJmxt3nCdb/R8cqqNDzew=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=YARw/DDGRFHqaOVHzgVSdD7NsAyo5r6JXJvYFXDwjtE0xbFNqe3Z6x0FnBv4kB4wo/+MVecpA/wtIofiiTXqiODd9pK/rghoUj1jXjrNk1I+ROrKhy16Q8+hH3+vVbeP0LjQrw2hfEZrQ8gQOikoTqSMwsPh/Gd5jLUBxNoikvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=msNTUbni; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-41c7ac73fddso5187255e9.3
        for <bpf@vger.kernel.org>; Sat, 04 May 2024 05:22:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1714825345; x=1715430145; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=M2vp/JKI429/HHS37Iz8iVVeNzZRSNJFUP79XleGm+E=;
        b=msNTUbniHN4eIah67TwJEQ21evL/sJ+IvEBtnMKvwmbTsyA+qWgZ4JVWLKHBwelAFO
         FBWwFP9mduPYZpv+3qVttdlSjPBBCYRKJSasbIMCH9pAFxccOjbpT2tUBH4idbNRblOV
         bHHThWwjIRMBf9YNHwBZOL83txAZ/oG0brJguv5v5QUU1ADOgPGeDyhZ1wuZnW+Q0KAj
         GRNF6KkymIi9I8spVEb0dqp19tXsmsagj1eO7zmClZm+dSS2encMBxD+gY3O7QzsZKZ9
         Jk4Mdh7W+4EgWE0+o2kaz0r+LwczF8YbeVmLXTcodQ8D/P3/ARPkr/z/gu9IDJSQPa7m
         h0zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714825345; x=1715430145;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:message-id:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=M2vp/JKI429/HHS37Iz8iVVeNzZRSNJFUP79XleGm+E=;
        b=JwhIRKABmt0yfCXNtgmwW9Hs3baVlvBzxRoCFmlfRCdWp+78QPoKaNq4lZPu0bBmBu
         8hV/0I9tcMtwTiEJ1zUFUG9DOQQ7uoyTXDcm9esHYihgRoB5lj4ILEM9PoScp8HhPhj2
         Xk34nzoQwkoDRk9fumfTB8ot4dcY/XcA4dh6y2WGpNPJePcluW62ord1hAgy9zAm2HVB
         s73J7VAfi9+opN2H/stXzhKZ61I5J6Zd25oalnsi7WxxhOjjHd+1m2JgWyiikhASNwKc
         KwzpXdDvvhe5QiO+P6CY5NgKiNCYlsnb+VHweVv8DqG5XB4fhQfHb501XgAafmEBonQy
         PLOg==
X-Forwarded-Encrypted: i=1; AJvYcCXVILRrGugNqanMLPniobxS5mpyWIRkMmfsfzE/42gDfWq1e3P7lRU1WbMybUnbpcWXwXBUKOO0T2EShOw9ccJxlhp9
X-Gm-Message-State: AOJu0YzqQv3LGD9DRlRbidKt/e9NvzoX4lcKDo1yHNIfPDdcC75eof3a
	yYNIH+44mGFXe8S2Fb2HjBDrcFJ0Okoj5dODxI3PthW88f8BLQafeeZnr6T71Sw=
X-Google-Smtp-Source: AGHT+IFF4yjgKipag7jhN7Q7o11f1T7BsWiIH2Qt4T9Q5z3xzGtEXUPJe6y2u65rRYlosu9Kt8H7vw==
X-Received: by 2002:a05:600c:3586:b0:41c:b44:f917 with SMTP id p6-20020a05600c358600b0041c0b44f917mr5631753wmq.22.1714825345404;
        Sat, 04 May 2024 05:22:25 -0700 (PDT)
Received: from localhost ([102.222.70.76])
        by smtp.gmail.com with ESMTPSA id d1-20020a05600c34c100b0041c130520f3sm12850227wmq.6.2024.05.04.05.22.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 May 2024 05:22:25 -0700 (PDT)
Date: Sat, 4 May 2024 15:22:21 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: oe-kbuild@lists.linux.dev,
	Siddharth Chintamaneni <sidchintamaneni@gmail.com>,
	bpf@vger.kernel.org
Cc: lkp@intel.com, oe-kbuild-all@lists.linux.dev,
	alexei.starovoitov@gmail.com, daniel@iogearbox.net,
	olsajiri@gmail.com, andrii@kernel.org, yonghong.song@linux.dev,
	rjsu26@vt.edu, sairoop@vt.edu,
	Siddharth Chintamaneni <sidchintamaneni@vt.edu>,
	syzbot+8bdfc2c53fb2b63e1871@syzkaller.appspotmail.com
Subject: Re: [PATCH bpf-next 1/2] Patch to Fix deadlocks in queue and stack
 maps
Message-ID: <e5286af1-53cb-40f1-a0c9-601e2a368114@moroto.mountain>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240429165658.1305969-1-sidchintamaneni@gmail.com>

Hi Siddharth,

kernel test robot noticed the following build warnings:

url:    https://github.com/intel-lab-lkp/linux/commits/Siddharth-Chintamaneni/Added-selftests-to-check-deadlocks-in-queue-and-stack-map/20240430-142201
base:   https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git master
patch link:    https://lore.kernel.org/r/20240429165658.1305969-1-sidchintamaneni%40gmail.com
patch subject: [PATCH bpf-next 1/2] Patch to Fix deadlocks in queue and stack maps
config: i386-randconfig-141-20240504 (https://download.01.org/0day-ci/archive/20240504/202405041108.2Up5HT0H-lkp@intel.com/config)
compiler: clang version 18.1.4 (https://github.com/llvm/llvm-project e6c3289804a67ea0bb6a86fadbe454dd93b8d855)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
| Closes: https://lore.kernel.org/r/202405041108.2Up5HT0H-lkp@intel.com/

smatch warnings:
kernel/bpf/queue_stack_maps.c:273 queue_stack_map_push_elem() warn: inconsistent returns 'irq_flags'.

vim +/irq_flags +273 kernel/bpf/queue_stack_maps.c

f1a2e44a3aeccb Mauricio Vasquez B     2018-10-18  219  
f1a2e44a3aeccb Mauricio Vasquez B     2018-10-18  220  /* Called from syscall or from eBPF program */
d7ba4cc900bf1e JP Kobryn              2023-03-22  221  static long queue_stack_map_push_elem(struct bpf_map *map, void *value,
f1a2e44a3aeccb Mauricio Vasquez B     2018-10-18  222  				      u64 flags)
f1a2e44a3aeccb Mauricio Vasquez B     2018-10-18  223  {
f1a2e44a3aeccb Mauricio Vasquez B     2018-10-18  224  	struct bpf_queue_stack *qs = bpf_queue_stack(map);
f1a2e44a3aeccb Mauricio Vasquez B     2018-10-18  225  	unsigned long irq_flags;
f1a2e44a3aeccb Mauricio Vasquez B     2018-10-18  226  	int err = 0;
f1a2e44a3aeccb Mauricio Vasquez B     2018-10-18  227  	void *dst;
f1a2e44a3aeccb Mauricio Vasquez B     2018-10-18  228  
568ce03b978beb Siddharth Chintamaneni 2024-04-29  229  	preempt_disable();
568ce03b978beb Siddharth Chintamaneni 2024-04-29  230  	local_irq_save(irq_flags);
568ce03b978beb Siddharth Chintamaneni 2024-04-29  231  	if (unlikely(__this_cpu_inc_return(*(qs->map_locked)) != 1)) {
568ce03b978beb Siddharth Chintamaneni 2024-04-29  232  		__this_cpu_dec(*(qs->map_locked));
568ce03b978beb Siddharth Chintamaneni 2024-04-29  233  		local_irq_restore(irq_flags);
568ce03b978beb Siddharth Chintamaneni 2024-04-29  234  		preempt_enable();
568ce03b978beb Siddharth Chintamaneni 2024-04-29  235  		return -EBUSY;
568ce03b978beb Siddharth Chintamaneni 2024-04-29  236  	}
568ce03b978beb Siddharth Chintamaneni 2024-04-29  237  	preempt_enable();
568ce03b978beb Siddharth Chintamaneni 2024-04-29  238  
f1a2e44a3aeccb Mauricio Vasquez B     2018-10-18  239  	/* BPF_EXIST is used to force making room for a new element in case the
f1a2e44a3aeccb Mauricio Vasquez B     2018-10-18  240  	 * map is full
f1a2e44a3aeccb Mauricio Vasquez B     2018-10-18  241  	 */
f1a2e44a3aeccb Mauricio Vasquez B     2018-10-18  242  	bool replace = (flags & BPF_EXIST);
f1a2e44a3aeccb Mauricio Vasquez B     2018-10-18  243  
f1a2e44a3aeccb Mauricio Vasquez B     2018-10-18  244  	/* Check supported flags for queue and stack maps */
f1a2e44a3aeccb Mauricio Vasquez B     2018-10-18  245  	if (flags & BPF_NOEXIST || flags > BPF_EXIST)
f1a2e44a3aeccb Mauricio Vasquez B     2018-10-18  246  		return -EINVAL;

local_irq_restore(irq_flags) before returning.

f1a2e44a3aeccb Mauricio Vasquez B     2018-10-18  247  
a34a9f1a19afe9 Toke Høiland-Jørgensen 2023-09-11  248  	if (in_nmi()) {
a34a9f1a19afe9 Toke Høiland-Jørgensen 2023-09-11  249  		if (!raw_spin_trylock_irqsave(&qs->lock, irq_flags))


_irqsave can't be nested.  Has this code been tested?  Perhaps it works
because the callers always call this with IRQs disabled.

a34a9f1a19afe9 Toke Høiland-Jørgensen 2023-09-11  250  			return -EBUSY;
a34a9f1a19afe9 Toke Høiland-Jørgensen 2023-09-11  251  	} else {
f1a2e44a3aeccb Mauricio Vasquez B     2018-10-18  252  		raw_spin_lock_irqsave(&qs->lock, irq_flags);
a34a9f1a19afe9 Toke Høiland-Jørgensen 2023-09-11  253  	}
f1a2e44a3aeccb Mauricio Vasquez B     2018-10-18  254  
f1a2e44a3aeccb Mauricio Vasquez B     2018-10-18  255  	if (queue_stack_map_is_full(qs)) {
f1a2e44a3aeccb Mauricio Vasquez B     2018-10-18  256  		if (!replace) {
f1a2e44a3aeccb Mauricio Vasquez B     2018-10-18  257  			err = -E2BIG;
f1a2e44a3aeccb Mauricio Vasquez B     2018-10-18  258  			goto out;
f1a2e44a3aeccb Mauricio Vasquez B     2018-10-18  259  		}
f1a2e44a3aeccb Mauricio Vasquez B     2018-10-18  260  		/* advance tail pointer to overwrite oldest element */
f1a2e44a3aeccb Mauricio Vasquez B     2018-10-18  261  		if (unlikely(++qs->tail >= qs->size))
f1a2e44a3aeccb Mauricio Vasquez B     2018-10-18  262  			qs->tail = 0;
f1a2e44a3aeccb Mauricio Vasquez B     2018-10-18  263  	}
f1a2e44a3aeccb Mauricio Vasquez B     2018-10-18  264  
f1a2e44a3aeccb Mauricio Vasquez B     2018-10-18  265  	dst = &qs->elements[qs->head * qs->map.value_size];
f1a2e44a3aeccb Mauricio Vasquez B     2018-10-18  266  	memcpy(dst, value, qs->map.value_size);
f1a2e44a3aeccb Mauricio Vasquez B     2018-10-18  267  
f1a2e44a3aeccb Mauricio Vasquez B     2018-10-18  268  	if (unlikely(++qs->head >= qs->size))
f1a2e44a3aeccb Mauricio Vasquez B     2018-10-18  269  		qs->head = 0;
f1a2e44a3aeccb Mauricio Vasquez B     2018-10-18  270  
f1a2e44a3aeccb Mauricio Vasquez B     2018-10-18  271  out:
f1a2e44a3aeccb Mauricio Vasquez B     2018-10-18  272  	raw_spin_unlock_irqrestore(&qs->lock, irq_flags);
f1a2e44a3aeccb Mauricio Vasquez B     2018-10-18 @273  	return err;
f1a2e44a3aeccb Mauricio Vasquez B     2018-10-18  274  }

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


