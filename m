Return-Path: <bpf+bounces-66980-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E6B12B3BB09
	for <lists+bpf@lfdr.de>; Fri, 29 Aug 2025 14:19:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CFBF3208014
	for <lists+bpf@lfdr.de>; Fri, 29 Aug 2025 12:19:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52F15314B98;
	Fri, 29 Aug 2025 12:18:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JQ0/AxIO"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA4E13128BA;
	Fri, 29 Aug 2025 12:18:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756469934; cv=none; b=j+avQN4WhEr7qXpDuA/3nhceLiCx2nMLiANtB4U3xGPsCcmFsdKQ73zdCesgJvKUYW3Gkjk5YeEWLfpsdkuT7kThPTFWA5UeDUkP1Qy8FCufqzoQS1OSATLB+fOkIIqiq2ErXMnOoiY2ormYdotsQ6vTGLhuxRLtU1dCLDRSIgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756469934; c=relaxed/simple;
	bh=lmOaDJrWsALHNdIkFkPEn+1/tHhvy8ASz+0CpcTOxMQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=aixO4Udse8s1/Be5EQ+hm5B9V1oK4EoGuqdUm4w7WZN6OgfQjs9oDhXgFjHHuKBX6oB6pN/VihjWOlSnlzAU7WZg5OrRBnvWeTs7xPkgdvtSa+K9u01GU0NVVPZOrZ1nq17ue8hc+/U1WWO2OoUou5xWsMxaTmWf/Yo/c/qSaoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JQ0/AxIO; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756469933; x=1788005933;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=lmOaDJrWsALHNdIkFkPEn+1/tHhvy8ASz+0CpcTOxMQ=;
  b=JQ0/AxIOhGOdNMLF+qwZWK/qJiXTSwfEjc9AjX87xrVNj81JYdTRUYja
   V7Zb2LTkZJLsheaBDsqGMptJ5WLRby9tzbmbVTPMLbVDGXjofwZLzfW44
   uOWocqbtuuJjlRsXxevgLMALWmEsvl5IiIVUgq/yRnlEAAkyhKziMiGiq
   8LQ0HYP1ZzdKGkkj3GmzQUSZySM6I71X9QFAhieJDOOWEHkEahigArV0G
   EZKhduHmce0JLMY2Jfh70zm2ysBhf+FZp5eGkImBMlzoWCDD2/UUeD67o
   gUoOPBKJW64YrJe4R/5lKaE/2DIWL5soyk1zj202MgephKE5eRnOICCye
   A==;
X-CSE-ConnectionGUID: HteoTLb2Tjy5YxO8qrXg+A==
X-CSE-MsgGUID: J3mI7IycSxOWSYmo7wvxqg==
X-IronPort-AV: E=McAfee;i="6800,10657,11536"; a="58603807"
X-IronPort-AV: E=Sophos;i="6.18,221,1751266800"; 
   d="scan'208";a="58603807"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2025 05:18:51 -0700
X-CSE-ConnectionGUID: FceyOGKfTMK8J/ArNXLz6w==
X-CSE-MsgGUID: nahg4MG6QSGDgmwgF/j0Ug==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,221,1751266800"; 
   d="scan'208";a="170753940"
Received: from hrotuna-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.246.58])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2025 05:18:22 -0700
From: Jani Nikula <jani.nikula@intel.com>
To: Bagas Sanjaya <bagasdotme@gmail.com>, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>, Linux Documentation
 <linux-doc@vger.kernel.org>, Linux DAMON <damon@lists.linux.dev>, Linux
 Memory Management List <linux-mm@kvack.org>, Linux Power Management
 <linux-pm@vger.kernel.org>, Linux Block Devices
 <linux-block@vger.kernel.org>, Linux BPF <bpf@vger.kernel.org>, Linux
 Kernel Workflows <workflows@vger.kernel.org>, Linux KASAN
 <kasan-dev@googlegroups.com>, Linux Devicetree
 <devicetree@vger.kernel.org>, Linux fsverity <fsverity@lists.linux.dev>,
 Linux MTD <linux-mtd@lists.infradead.org>, Linux DRI Development
 <dri-devel@lists.freedesktop.org>, Linux Kernel Build System
 <linux-lbuild@vger.kernel.org>, Linux Networking <netdev@vger.kernel.org>,
 Linux Sound <linux-sound@vger.kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>,
 Peter Zijlstra <peterz@infradead.org>, Josh Poimboeuf
 <jpoimboe@kernel.org>, Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
 Jonathan Corbet <corbet@lwn.net>, SeongJae Park <sj@kernel.org>, Andrew
 Morton <akpm@linux-foundation.org>, David Hildenbrand <david@redhat.com>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, "Liam R. Howlett"
 <Liam.Howlett@oracle.com>, Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport
 <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, Michal Hocko
 <mhocko@suse.com>, Huang Rui <ray.huang@amd.com>, "Gautham R. Shenoy"
 <gautham.shenoy@amd.com>, Mario Limonciello <mario.limonciello@amd.com>,
 Perry Yuan <perry.yuan@amd.com>, Jens Axboe <axboe@kernel.dk>, Alexei
 Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau
 <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu
 <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, John Fastabend
 <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, Stanislav
 Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa
 <jolsa@kernel.org>, Dwaipayan Ray <dwaipayanray1@gmail.com>, Lukas Bulwahn
 <lukas.bulwahn@gmail.com>, Joe Perches <joe@perches.com>, Andrey Ryabinin
 <ryabinin.a.a@gmail.com>, Alexander Potapenko <glider@google.com>, Andrey
 Konovalov <andreyknvl@gmail.com>, Dmitry Vyukov <dvyukov@google.com>,
 Vincenzo Frascino <vincenzo.frascino@arm.com>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Eric Biggers <ebiggers@kernel.org>, tytso@mit.edu,
 Richard Weinberger <richard@nod.at>, Zhihao Cheng
 <chengzhihao1@huawei.com>, David Airlie <airlied@gmail.com>, Simona Vetter
 <simona@ffwll.ch>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann
 <tzimmermann@suse.de>, Nathan Chancellor <nathan@kernel.org>, Nicolas
 Schier <nicolas.schier@linux.dev>, Ingo Molnar <mingo@redhat.com>, Will
 Deacon <will@kernel.org>, Boqun Feng <boqun.feng@gmail.com>, Waiman Long
 <longman@redhat.com>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Shay Agroskin
 <shayagr@amazon.com>, Arthur Kiyanovski <akiyano@amazon.com>, David
 Arinzon <darinzon@amazon.com>, Saeed Bishara <saeedb@amazon.com>, Andrew
 Lunn <andrew@lunn.ch>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown
 <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai
 <tiwai@suse.com>, Alexandru Ciobotaru <alcioa@amazon.com>, The AWS Nitro
 Enclaves Team <aws-nitro-enclaves-devel@amazon.com>, Jesper Dangaard
 Brouer <hawk@kernel.org>, Bagas Sanjaya <bagasdotme@gmail.com>, Laurent
 Pinchart <laurent.pinchart@ideasonboard.com>, Steve French
 <stfrench@microsoft.com>, Meetakshi Setiya <msetiya@microsoft.com>, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>, "Martin K. Petersen"
 <martin.petersen@oracle.com>, Bart Van Assche <bvanassche@acm.org>, Thomas
 =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>, Masahiro Yamada
 <masahiroy@kernel.org>
Subject: Re: [PATCH 00/14] Internalize www.kernel.org/doc cross-reference
In-Reply-To: <20250829075524.45635-1-bagasdotme@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20250829075524.45635-1-bagasdotme@gmail.com>
Date: Fri, 29 Aug 2025 15:18:20 +0300
Message-ID: <437912a24e94673c2355a2b7b50c3c4b6f68fcc6@intel.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Fri, 29 Aug 2025, Bagas Sanjaya <bagasdotme@gmail.com> wrote:
> Cross-references to other docs (so-called internal links) are typically
> done following Documentation/doc-guide/sphinx.rst: either simply
> write the target docs (preferred) or use :doc: or :ref: reST directives
> (for use-cases like having anchor text or cross-referencing sections).
> In some places, however, links to https://www.kernel.org/doc
> are used instead (outgoing, external links), owing inconsistency as
> these requires Internet connection only to see docs that otherwise
> can be accessed locally (after building with ``make htmldocs``).
>
> Convert such external links to internal links. Note that this does not
> cover docs.kernel.org links nor touching Documentation/tools (as
> docs containing external links are in manpages).

FWIW, I'd much prefer using :ref: on rst anchors (that automatically
pick the link text from the target heading) instead of manually adding
link texts and file references.

i.e.

.. _some_target:

Heading After Some Target
=========================

See :ref:`some_target`.

Will generate "See Heading After Some Target".


BR,
Jani.


-- 
Jani Nikula, Intel

