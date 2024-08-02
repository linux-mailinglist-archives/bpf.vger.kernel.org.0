Return-Path: <bpf+bounces-36318-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 77FA89464E7
	for <lists+bpf@lfdr.de>; Fri,  2 Aug 2024 23:17:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8EB7D1C2123B
	for <lists+bpf@lfdr.de>; Fri,  2 Aug 2024 21:17:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48D966A325;
	Fri,  2 Aug 2024 21:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="F2ri5abC"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82D791ABEB8
	for <bpf@vger.kernel.org>; Fri,  2 Aug 2024 21:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722633447; cv=none; b=MdHaxTNKi7Txo25njMBJKCoNyqexzhMMVOs5OtUZXyCnmLnobanFPNgxbndO3mBg5rU7d8gpQ8XCrgHXGpwgjethteG4ON7d0WoNapNn3IkfxkMRZiczw64q1vkZL4XvOVPcZ33l4bEe/272dhl1Vu/gy6hORUX0kIJ+YlV9nd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722633447; c=relaxed/simple;
	bh=CJVx6hKBEtA2C6xwKu+85psWN00Yma38PQ634qW6kgc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CQ5DD5SvHjKaRucppAPtRs5tp7r6g6BolAWK2cHawOVdJne7FCs/MKoPUKmEpWp/P8qO+PV0Yaaf9+lxrsx9tnk+uzWZitBLTpZnzglxkPtC+Y3MQEhEtTg+LqmKGThZKcbz9cMfzFw2VwDpTRV6jf3WLgAbHnCs9w4hBfLsrg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=F2ri5abC; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1fc491f9b55so70582245ad.3
        for <bpf@vger.kernel.org>; Fri, 02 Aug 2024 14:17:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1722633446; x=1723238246; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Xg/nIkEBOUj6ERsU4SsqgIXyx4I9NBiRgxttKQa94Lg=;
        b=F2ri5abCF7oBW+vkjlG5z4/CWOMxso5IPddBFyPRStDF4+lR9Jw4uYb8vrEBl7Pt7r
         2I8mLYTPWP4xMtYR9UN8rFVDbQtAib4IoS6evsK/FRX9LXOh68Z0g+9kBZX6/kQnB4w+
         YT9sQQt9m2Ytu8J7cstEYo2oj8hdp+NBPeJFU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722633446; x=1723238246;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Xg/nIkEBOUj6ERsU4SsqgIXyx4I9NBiRgxttKQa94Lg=;
        b=g0oRJQkoRo8GTFCsF8GC/PqCGsAYDssn/vU4VoGDvnQ+AKoE4M6u+kvMKnX10V9x5k
         McmSDwjRnpHyHkVtqM1RHsH+6YdlyzJnKkh7aIg9r2CokTt6ii8+9OzvzDC5NhPjFfrJ
         dth9X5NmlWVc4CExbnpqfTZBdNj7ZKpfxATLtvOri7t7zity4hl5Ard+Z4t+VncL/K4F
         LKuFW774vIdmT74DkDRRK8IBETg8p5m189cDEKbp1ubH4A0fwdGdxHIQfc/P+QTbF++J
         w/inWlXvoQIMVtUHmLeHdLmXmEO36U7V8HcZrWygoRIwuxOIKTAPUixtfiqojpwkpjDQ
         aC5A==
X-Forwarded-Encrypted: i=1; AJvYcCXulBAjcCkP5JOh1R1cclC2CCYOHSS7kRWyX2+4jcNCQovqHSOL72Pkq8Fsxe2UKV1b/dSaqHjeIWnVIeuAVtaWfbtg
X-Gm-Message-State: AOJu0YwDmrFCEdr6ceINhE4YcnOx0hsPMLow+gr+b1Os784QI3Jz5QcL
	/CjHAJM2ZKCmAFeLQ98o8OquMkK8y0hpSnL3Vv0VG4fNaNDs6fP2rq+Fo8DFtA==
X-Google-Smtp-Source: AGHT+IFFmu0KeHAGUS32wdXePcs4h01hwELYQaMMmW8APwdIiTFVYyrGB7g2Uh4wIWrPv5KZReIUyg==
X-Received: by 2002:a17:902:d492:b0:1fb:8419:8384 with SMTP id d9443c01a7336-1ff5722d6e9mr59497725ad.13.1722633445808;
        Fri, 02 Aug 2024 14:17:25 -0700 (PDT)
Received: from localhost ([2620:15c:9d:2:ac3b:d38d:edce:bf32])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-1ff5916e836sm21683095ad.184.2024.08.02.14.17.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Aug 2024 14:17:25 -0700 (PDT)
Date: Fri, 2 Aug 2024 14:17:23 -0700
From: Brian Norris <briannorris@chromium.org>
To: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>,
	Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>,
	Thomas Richter <tmricht@linux.ibm.com>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org,
	Masahiro Yamada <masahiroy@kernel.org>, bpf@vger.kernel.org,
	linux-kbuild@vger.kernel.org, Jiri Olsa <olsajiri@gmail.com>
Subject: Re: [PATCH v4 2/3] tools build: Avoid circular .fixdep-in.o.cmd
 issues
Message-ID: <Zq1M43UGQCkdLBNn@google.com>
References: <20240715203325.3832977-1-briannorris@chromium.org>
 <20240715203325.3832977-3-briannorris@chromium.org>
 <ZpYngEl9XKumuow5@krava>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZpYngEl9XKumuow5@krava>

Hi Arnaldo,

On Tue, Jul 16, 2024 at 09:55:44AM +0200, Jiri Olsa wrote:
> so usually Arnaldo takes changes for tools/build, Arnaldo, could you please take a look?
> but still there'are the tools/lib/bpf bits..

Would you have some time to look at this series and whether it's ready
to be applied? Several folks have already acked one or more patches.

In case you've lost context on the series, here's a lore link for the
cover letter:

  [PATCH v4 0/3] tools build: Incorrect fixdep dependencies
  https://lore.kernel.org/all/20240715203325.3832977-1-briannorris@chromium.org/

Thanks,
Brian

