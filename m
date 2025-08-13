Return-Path: <bpf+bounces-65499-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C207CB24516
	for <lists+bpf@lfdr.de>; Wed, 13 Aug 2025 11:15:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 132C5189303C
	for <lists+bpf@lfdr.de>; Wed, 13 Aug 2025 09:15:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C23662EF654;
	Wed, 13 Aug 2025 09:15:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ilPFJDdo"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0A7675809
	for <bpf@vger.kernel.org>; Wed, 13 Aug 2025 09:15:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755076525; cv=none; b=axeSU6yWwgAids7iQWMBM/nCTntHJTnJVWZKR+FLtvRVK+n9naYYjjcutWXdQx4SePXt+wwb6DklICsEVWAz1GEwNOhrG+rzoLSIHNL/pMEI3SLVVZ5PgxrZ6KYzFG7juULFjYAFsfpxnifIaDW0tl0kiFTki7/5jYnzSa8PsJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755076525; c=relaxed/simple;
	bh=FJ9S9xsVuGUMDuUEQIwBA9l7/TjDR/EkMLgbR+IWJmg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SlNumtvZSoaiq/HjOjzLbbhGxivocPuXCa4EDGZB9qX7oZumnaNe8yDu77M41phlj8R1E/sDa3dyQgqbsUoq4tReOo2sMx0YwnOQzYUD34Bmk3Qo7YM1aS8f39hdMuj4hCY2/fa1I6kwdSyZrHJ9bU62VURXrCGgjeFn9tja0RQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ilPFJDdo; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755076522;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FJ9S9xsVuGUMDuUEQIwBA9l7/TjDR/EkMLgbR+IWJmg=;
	b=ilPFJDdopF+k9Ta7y9fXA7kywg59EIaMKW0yHGjsdN7C2nmcIpzTNxDfacr0hq5DK3/4Qe
	l9eZltE7oP/2ViB5jzdO+4ubohO6PbeZhA8js5pcimFGuwnhCe5tpmnT2f2T5LbbjCUU2E
	WVQ+kJxlb/AIEa+fqBZl6V87rZgCihA=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-140-E3guf-LGPCOgoavMQSPrXg-1; Wed, 13 Aug 2025 05:15:21 -0400
X-MC-Unique: E3guf-LGPCOgoavMQSPrXg-1
X-Mimecast-MFC-AGG-ID: E3guf-LGPCOgoavMQSPrXg_1755076520
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-70739ef4ab4so14204166d6.0
        for <bpf@vger.kernel.org>; Wed, 13 Aug 2025 02:15:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755076520; x=1755681320;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FJ9S9xsVuGUMDuUEQIwBA9l7/TjDR/EkMLgbR+IWJmg=;
        b=K/lcMDlLvOxu89oMrjUv/WeA8Q4g6CziRuHaciO0hotZuGTWfkDcsp+7GVYugCNpoV
         Dg74C6ju9/yHd4r0hGaH13Fc0GNy5ispgEvTivj55Wg3NOjrX2ArzRw7EujLRzZm/UMC
         Q4Zr8OEDXkB1bi/WUChwh5wunxccEOH3qHITW41hsXVyazDxKGC3iZfVLFLENhNEyEHA
         a93Ud8uUpnNUL9T9LDGwaw6u9oJ67SebmU4zseBUCMZNAaxBwoiSgvuDd1J194zKraUD
         KKIoWb1WPlxYHsTud6GP0K/Iv/RazAk8nqRdL7b53LEMqT3kxZ9G17ZfcJEipQZT3ViK
         wjfg==
X-Forwarded-Encrypted: i=1; AJvYcCWHaYGo5pN35oBbEtRVYb2XJa4g7fGywp98/U4ZrfGC4jko96Mdpa1yIXsBAKolDanFK04=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw03VJjbqeMn6rOfUXJyrAO2OPo1ONm1i8wkD6k1DgYcumBS74Y
	arslxjKJ3iCArvjgj+5ls+CUE1ZegKdeOmlwL3OSj1LgL2pFD9XWOYpCod2kK2atIRc+P77g4xk
	eRsrgxSgqTYIfI22goh5n47jSHPv+rQ9v8pcgaHcur+vcvhYmoculNQ==
X-Gm-Gg: ASbGncsGEfFRtbPrXfMVHvFzDDOUBBNYs1Y9j90U10Vb1kFKt8X2XxeH+BUkMI+Q+eW
	sQikEyE2d+q29z2rnXlj/4aS1X5fvkJJ1n8vviFreLA1yEqVkXukg7J0dxvTh6Zn5CwZolezemD
	Ae1f7mLG8Azw4+RjeF8an9cV3WC4N7DD1zzqePaoISsw5E3g7HugRrv889rR+5k9QpmS5y5Ve8M
	KXhGyqgk9tdW9xr5YjI0sXsF6YAHKAU1xpp3WA5uPQg/wyK2WUt1VmLTfBaTmiwMA4DEF62joRk
	R6zqi1gNciQUXxnvXc0jKRf6Uz84hs7wJ2rTzrId1HPcjKsyyNCkMzQP45IvF5yjPgR6
X-Received: by 2002:a05:6214:623:b0:707:2b04:b038 with SMTP id 6a1803df08f44-709eb1feffdmr19627296d6.23.1755076520573;
        Wed, 13 Aug 2025 02:15:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEV/OQOwQfKOsKAz5wKdJV7tOoeeQil/sc1ZfgToMGixY0ksc6c2kTdU4P+wy3LssNk2AeWLg==
X-Received: by 2002:a05:6214:623:b0:707:2b04:b038 with SMTP id 6a1803df08f44-709eb1feffdmr19626886d6.23.1755076520004;
        Wed, 13 Aug 2025 02:15:20 -0700 (PDT)
Received: from jlelli-thinkpadt14gen4.remote.csb ([151.43.47.41])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-7077c9da7dcsm190924776d6.12.2025.08.13.02.15.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Aug 2025 02:15:18 -0700 (PDT)
Date: Wed, 13 Aug 2025 11:15:10 +0200
From: Juri Lelli <juri.lelli@redhat.com>
To: Joel Fernandes <joelagnelf@nvidia.com>
Cc: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>, Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>, Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>, bpf@vger.kernel.org
Subject: Re: [PATCH -rebased 00/15] Add a deadline server for sched_ext tasks
Message-ID: <aJxXnj4C2Nfp5mmI@jlelli-thinkpadt14gen4.remote.csb>
References: <20250809184800.129831-1-joelagnelf@nvidia.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250809184800.129831-1-joelagnelf@nvidia.com>

Hi Joel,

On 09/08/25 14:47, Joel Fernandes wrote:
> Just rebased on Linus's master and made adjustments. These patches have been

I failed to apply these to both linus and tip master. What's your
baseline commit?

Thanks,
Juri


