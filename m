Return-Path: <bpf+bounces-59992-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 25DFAAD0C10
	for <lists+bpf@lfdr.de>; Sat,  7 Jun 2025 11:16:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4362C188EFC5
	for <lists+bpf@lfdr.de>; Sat,  7 Jun 2025 09:17:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 120641FDE09;
	Sat,  7 Jun 2025 09:16:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="f8OV1/iO"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7939420B1F5;
	Sat,  7 Jun 2025 09:16:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749287796; cv=none; b=K+hc/7jfH0xQNCz5viTmzFpM/4qc8ndhO1GmcAooudoSWUglY8bhjY+B1NgKyjOl42cpFDqubwbwC2It3yGVBvGrJ5orU+kGkIwcT8/bRm8QPpMqXsOk372wTc/pCwVmEF0mYwI1h+SfWpCjAPaRXx4XFt8iRKPDwCFjwhKn2/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749287796; c=relaxed/simple;
	bh=gWmUoikykXIx3fJ+gHUZhWY+dfFiy2UXjNHyIg+k0BI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q31KAuGnTuYS0Pk0khBOKTIrrl5R7zZgUs/T4Oq/tRV3GRULwDSHLGfoQ8bgGDDz941nvl5+/A50zp0J3qxyTVnSfJCLS/i4SHkDVJwkvrw7Ek5VtW2bSrGT+fEs7GetyaF6bAdtUGvO7bjKwCKYxMoSZJ8byrEjIK9TsXhEc4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=f8OV1/iO; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749287793; x=1780823793;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=gWmUoikykXIx3fJ+gHUZhWY+dfFiy2UXjNHyIg+k0BI=;
  b=f8OV1/iOZCyj9H0+EGZmrTpYZ93um3oof8WZAhmsyMDHo4dpjUjQGFdK
   12Us1Ob+jDt1H87fRB9iz3Z84AlGemBnqWHfHc491u4O7Nk/hidtRNn0q
   lbL3uvXQ6abfaFqcYb3Jw80o3ov1zCcKNGt8k+xaqXUfDEXw+xMqo9BDM
   x+BfvKUPAoIdoN1wQB+KqAn7IyFVlDfY8kj7RVl7x0Lb9Hl8XFXdJtYRz
   Wm18XyNlHL6+E31yXq2hDc4pnIB1L8eWAz1MY5xB9M6tON1sz4YRpU/LU
   zk22Yz0w0qvN6YtIuE1eoKRoXIn9fKBDymsDKlz6OHUUUCSeh2MfwVqpe
   A==;
X-CSE-ConnectionGUID: jfJEiBJfQUWrW9tVp1V+RA==
X-CSE-MsgGUID: 1E7ElSbwS8GK9oTYoUWYSQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11456"; a="51292715"
X-IronPort-AV: E=Sophos;i="6.16,217,1744095600"; 
   d="scan'208";a="51292715"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jun 2025 02:16:33 -0700
X-CSE-ConnectionGUID: x+aD3VZ9T+unn96obeRHRw==
X-CSE-MsgGUID: wMXBqMPNTIWojyztPRxQ/Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,217,1744095600"; 
   d="scan'208";a="176986310"
Received: from lkp-server01.sh.intel.com (HELO e8142ee1dce2) ([10.239.97.150])
  by orviesa002.jf.intel.com with ESMTP; 07 Jun 2025 02:16:30 -0700
Received: from kbuild by e8142ee1dce2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uNpf9-0005aL-2j;
	Sat, 07 Jun 2025 09:16:27 +0000
Date: Sat, 7 Jun 2025 17:16:19 +0800
From: kernel test robot <lkp@intel.com>
To: KP Singh <kpsingh@kernel.org>, bpf@vger.kernel.org,
	linux-security-module@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, bboscaccy@linux.microsoft.com,
	paul@paul-moore.com, kys@microsoft.com, ast@kernel.org,
	daniel@iogearbox.net, andrii@kernel.org,
	KP Singh <kpsingh@kernel.org>
Subject: Re: [PATCH 05/12] libbpf: Support exclusive map creation
Message-ID: <202506071746.cWvht6xb-lkp@intel.com>
References: <20250606232914.317094-6-kpsingh@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250606232914.317094-6-kpsingh@kernel.org>

Hi KP,

kernel test robot noticed the following build errors:

[auto build test ERROR on bpf-next/net]
[also build test ERROR on bpf-next/master bpf/master linus/master next-20250606]
[cannot apply to v6.15]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/KP-Singh/bpf-Implement-an-internal-helper-for-SHA256-hashing/20250607-073052
base:   https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git net
patch link:    https://lore.kernel.org/r/20250606232914.317094-6-kpsingh%40kernel.org
patch subject: [PATCH 05/12] libbpf: Support exclusive map creation
config: i386-buildonly-randconfig-003-20250607 (https://download.01.org/0day-ci/archive/20250607/202506071746.cWvht6xb-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250607/202506071746.cWvht6xb-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202506071746.cWvht6xb-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from libbpf_errno.c:14:
>> libbpf.h:1264:5: error: redundant redeclaration of 'bpf_map__make_exclusive' [-Werror=redundant-decls]
    1264 | int bpf_map__make_exclusive(struct bpf_map *map, struct bpf_program *prog);
         |     ^~~~~~~~~~~~~~~~~~~~~~~
   libbpf.h:1262:16: note: previous declaration of 'bpf_map__make_exclusive' with type 'int(struct bpf_map *, struct bpf_program *)'
    1262 | LIBBPF_API int bpf_map__make_exclusive(struct bpf_map *map, struct bpf_program *prog);
         |                ^~~~~~~~~~~~~~~~~~~~~~~
   In file included from btf_relocate.c:31:
>> libbpf.h:1264:5: error: redundant redeclaration of 'bpf_map__make_exclusive' [-Werror=redundant-decls]
    1264 | int bpf_map__make_exclusive(struct bpf_map *map, struct bpf_program *prog);
         |     ^~~~~~~~~~~~~~~~~~~~~~~
   libbpf.h:1262:16: note: previous declaration of 'bpf_map__make_exclusive' with type 'int(struct bpf_map *, struct bpf_program *)'
    1262 | LIBBPF_API int bpf_map__make_exclusive(struct bpf_map *map, struct bpf_program *prog);
         |                ^~~~~~~~~~~~~~~~~~~~~~~
   In file included from libbpf_internal.h:43,
                    from nlattr.c:14:
>> libbpf.h:1264:5: error: redundant redeclaration of 'bpf_map__make_exclusive' [-Werror=redundant-decls]
    1264 | int bpf_map__make_exclusive(struct bpf_map *map, struct bpf_program *prog);
         |     ^~~~~~~~~~~~~~~~~~~~~~~
   In file included from relo_core.c:64:
>> libbpf.h:1264:5: error: redundant redeclaration of 'bpf_map__make_exclusive' [-Werror=redundant-decls]
    1264 | int bpf_map__make_exclusive(struct bpf_map *map, struct bpf_program *prog);
         |     ^~~~~~~~~~~~~~~~~~~~~~~
   libbpf.h:1262:16: note: previous declaration of 'bpf_map__make_exclusive' with type 'int(struct bpf_map *, struct bpf_program *)'
    1262 | LIBBPF_API int bpf_map__make_exclusive(struct bpf_map *map, struct bpf_program *prog);
         |                ^~~~~~~~~~~~~~~~~~~~~~~
   libbpf.h:1262:16: note: previous declaration of 'bpf_map__make_exclusive' with type 'int(struct bpf_map *, struct bpf_program *)'
    1262 | LIBBPF_API int bpf_map__make_exclusive(struct bpf_map *map, struct bpf_program *prog);
         |                ^~~~~~~~~~~~~~~~~~~~~~~
   In file included from linker.c:24:
>> libbpf.h:1264:5: error: redundant redeclaration of 'bpf_map__make_exclusive' [-Werror=redundant-decls]
    1264 | int bpf_map__make_exclusive(struct bpf_map *map, struct bpf_program *prog);
         |     ^~~~~~~~~~~~~~~~~~~~~~~
   libbpf.h:1262:16: note: previous declaration of 'bpf_map__make_exclusive' with type 'int(struct bpf_map *, struct bpf_program *)'
    1262 | LIBBPF_API int bpf_map__make_exclusive(struct bpf_map *map, struct bpf_program *prog);
         |                ^~~~~~~~~~~~~~~~~~~~~~~
   In file included from libbpf_internal.h:43,
                    from strset.c:9:
>> libbpf.h:1264:5: error: redundant redeclaration of 'bpf_map__make_exclusive' [-Werror=redundant-decls]
    1264 | int bpf_map__make_exclusive(struct bpf_map *map, struct bpf_program *prog);
         |     ^~~~~~~~~~~~~~~~~~~~~~~
   libbpf.h:1262:16: note: previous declaration of 'bpf_map__make_exclusive' with type 'int(struct bpf_map *, struct bpf_program *)'
    1262 | LIBBPF_API int bpf_map__make_exclusive(struct bpf_map *map, struct bpf_program *prog);
         |                ^~~~~~~~~~~~~~~~~~~~~~~
   In file included from bpf_prog_linfo.c:8:
>> libbpf.h:1264:5: error: redundant redeclaration of 'bpf_map__make_exclusive' [-Werror=redundant-decls]
    1264 | int bpf_map__make_exclusive(struct bpf_map *map, struct bpf_program *prog);
         |     ^~~~~~~~~~~~~~~~~~~~~~~
   libbpf.h:1262:16: note: previous declaration of 'bpf_map__make_exclusive' with type 'int(struct bpf_map *, struct bpf_program *)'
    1262 | LIBBPF_API int bpf_map__make_exclusive(struct bpf_map *map, struct bpf_program *prog);
         |                ^~~~~~~~~~~~~~~~~~~~~~~
   In file included from btf_dump.c:22:
>> libbpf.h:1264:5: error: redundant redeclaration of 'bpf_map__make_exclusive' [-Werror=redundant-decls]
    1264 | int bpf_map__make_exclusive(struct bpf_map *map, struct bpf_program *prog);
         |     ^~~~~~~~~~~~~~~~~~~~~~~
   libbpf.h:1262:16: note: previous declaration of 'bpf_map__make_exclusive' with type 'int(struct bpf_map *, struct bpf_program *)'
    1262 | LIBBPF_API int bpf_map__make_exclusive(struct bpf_map *map, struct bpf_program *prog);
         |                ^~~~~~~~~~~~~~~~~~~~~~~
   In file included from ringbuf.c:21:
>> libbpf.h:1264:5: error: redundant redeclaration of 'bpf_map__make_exclusive' [-Werror=redundant-decls]
    1264 | int bpf_map__make_exclusive(struct bpf_map *map, struct bpf_program *prog);
         |     ^~~~~~~~~~~~~~~~~~~~~~~
   libbpf.h:1262:16: note: previous declaration of 'bpf_map__make_exclusive' with type 'int(struct bpf_map *, struct bpf_program *)'
    1262 | LIBBPF_API int bpf_map__make_exclusive(struct bpf_map *map, struct bpf_program *prog);
         |                ^~~~~~~~~~~~~~~~~~~~~~~
   In file included from libbpf_internal.h:43,
                    from elf.c:11:
>> libbpf.h:1264:5: error: redundant redeclaration of 'bpf_map__make_exclusive' [-Werror=redundant-decls]
    1264 | int bpf_map__make_exclusive(struct bpf_map *map, struct bpf_program *prog);
         |     ^~~~~~~~~~~~~~~~~~~~~~~
   libbpf.h:1262:16: note: previous declaration of 'bpf_map__make_exclusive' with type 'int(struct bpf_map *, struct bpf_program *)'
    1262 | LIBBPF_API int bpf_map__make_exclusive(struct bpf_map *map, struct bpf_program *prog);
         |                ^~~~~~~~~~~~~~~~~~~~~~~
   In file included from netlink.c:18:
>> libbpf.h:1264:5: error: redundant redeclaration of 'bpf_map__make_exclusive' [-Werror=redundant-decls]
    1264 | int bpf_map__make_exclusive(struct bpf_map *map, struct bpf_program *prog);
         |     ^~~~~~~~~~~~~~~~~~~~~~~
   libbpf.h:1262:16: note: previous declaration of 'bpf_map__make_exclusive' with type 'int(struct bpf_map *, struct bpf_program *)'
    1262 | LIBBPF_API int bpf_map__make_exclusive(struct bpf_map *map, struct bpf_program *prog);
         |                ^~~~~~~~~~~~~~~~~~~~~~~
   In file included from features.c:6:
>> libbpf.h:1264:5: error: redundant redeclaration of 'bpf_map__make_exclusive' [-Werror=redundant-decls]
    1264 | int bpf_map__make_exclusive(struct bpf_map *map, struct bpf_program *prog);
         |     ^~~~~~~~~~~~~~~~~~~~~~~
   libbpf.h:1262:16: note: previous declaration of 'bpf_map__make_exclusive' with type 'int(struct bpf_map *, struct bpf_program *)'
    1262 | LIBBPF_API int bpf_map__make_exclusive(struct bpf_map *map, struct bpf_program *prog);
         |                ^~~~~~~~~~~~~~~~~~~~~~~
   In file included from usdt.c:19:
>> libbpf.h:1264:5: error: redundant redeclaration of 'bpf_map__make_exclusive' [-Werror=redundant-decls]
    1264 | int bpf_map__make_exclusive(struct bpf_map *map, struct bpf_program *prog);
         |     ^~~~~~~~~~~~~~~~~~~~~~~
   libbpf.h:1262:16: note: previous declaration of 'bpf_map__make_exclusive' with type 'int(struct bpf_map *, struct bpf_program *)'
    1262 | LIBBPF_API int bpf_map__make_exclusive(struct bpf_map *map, struct bpf_program *prog);
         |                ^~~~~~~~~~~~~~~~~~~~~~~
   In file included from gen_loader.c:11:
>> libbpf.h:1264:5: error: redundant redeclaration of 'bpf_map__make_exclusive' [-Werror=redundant-decls]
    1264 | int bpf_map__make_exclusive(struct bpf_map *map, struct bpf_program *prog);
         |     ^~~~~~~~~~~~~~~~~~~~~~~
   libbpf.h:1262:16: note: previous declaration of 'bpf_map__make_exclusive' with type 'int(struct bpf_map *, struct bpf_program *)'
    1262 | LIBBPF_API int bpf_map__make_exclusive(struct bpf_map *map, struct bpf_program *prog);
         |                ^~~~~~~~~~~~~~~~~~~~~~~
   In file included from btf.c:22:
>> libbpf.h:1264:5: error: redundant redeclaration of 'bpf_map__make_exclusive' [-Werror=redundant-decls]
    1264 | int bpf_map__make_exclusive(struct bpf_map *map, struct bpf_program *prog);
         |     ^~~~~~~~~~~~~~~~~~~~~~~
   libbpf.h:1262:16: note: previous declaration of 'bpf_map__make_exclusive' with type 'int(struct bpf_map *, struct bpf_program *)'
    1262 | LIBBPF_API int bpf_map__make_exclusive(struct bpf_map *map, struct bpf_program *prog);
         |                ^~~~~~~~~~~~~~~~~~~~~~~
   In file included from libbpf_internal.h:43,
                    from zip.c:16:
>> libbpf.h:1264:5: error: redundant redeclaration of 'bpf_map__make_exclusive' [-Werror=redundant-decls]
    1264 | int bpf_map__make_exclusive(struct bpf_map *map, struct bpf_program *prog);
         |     ^~~~~~~~~~~~~~~~~~~~~~~
   libbpf.h:1262:16: note: previous declaration of 'bpf_map__make_exclusive' with type 'int(struct bpf_map *, struct bpf_program *)'
    1262 | LIBBPF_API int bpf_map__make_exclusive(struct bpf_map *map, struct bpf_program *prog);
         |                ^~~~~~~~~~~~~~~~~~~~~~~
   In file included from libbpf_probes.c:18:
>> libbpf.h:1264:5: error: redundant redeclaration of 'bpf_map__make_exclusive' [-Werror=redundant-decls]
    1264 | int bpf_map__make_exclusive(struct bpf_map *map, struct bpf_program *prog);
         |     ^~~~~~~~~~~~~~~~~~~~~~~
   libbpf.h:1262:16: note: previous declaration of 'bpf_map__make_exclusive' with type 'int(struct bpf_map *, struct bpf_program *)'
    1262 | LIBBPF_API int bpf_map__make_exclusive(struct bpf_map *map, struct bpf_program *prog);
         |                ^~~~~~~~~~~~~~~~~~~~~~~
   cc1: all warnings being treated as errors
   In file included from libbpf_internal.h:43,
                    from btf_iter.c:13:
>> libbpf.h:1264:5: error: redundant redeclaration of 'bpf_map__make_exclusive' [-Werror=redundant-decls]
    1264 | int bpf_map__make_exclusive(struct bpf_map *map, struct bpf_program *prog);
         |     ^~~~~~~~~~~~~~~~~~~~~~~
   libbpf.h:1262:16: note: previous declaration of 'bpf_map__make_exclusive' with type 'int(struct bpf_map *, struct bpf_program *)'
    1262 | LIBBPF_API int bpf_map__make_exclusive(struct bpf_map *map, struct bpf_program *prog);
         |                ^~~~~~~~~~~~~~~~~~~~~~~
   make[6]: *** [tools/build/Makefile.build:85: tools/bpf/resolve_btfids/libbpf/staticobjs/libbpf_errno.o] Error 1 shuffle=3326748311
   In file included from libbpf.c:53:
>> libbpf.h:1264:5: error: redundant redeclaration of 'bpf_map__make_exclusive' [-Werror=redundant-decls]
    1264 | int bpf_map__make_exclusive(struct bpf_map *map, struct bpf_program *prog);
         |     ^~~~~~~~~~~~~~~~~~~~~~~
   libbpf.h:1262:16: note: previous declaration of 'bpf_map__make_exclusive' with type 'int(struct bpf_map *, struct bpf_program *)'
    1262 | LIBBPF_API int bpf_map__make_exclusive(struct bpf_map *map, struct bpf_program *prog);
         |                ^~~~~~~~~~~~~~~~~~~~~~~
   cc1: all warnings being treated as errors
   In file included from bpf.c:36:
>> libbpf.h:1264:5: error: redundant redeclaration of 'bpf_map__make_exclusive' [-Werror=redundant-decls]
    1264 | int bpf_map__make_exclusive(struct bpf_map *map, struct bpf_program *prog);
         |     ^~~~~~~~~~~~~~~~~~~~~~~
   make[6]: *** [tools/build/Makefile.build:85: tools/bpf/resolve_btfids/libbpf/staticobjs/nlattr.o] Error 1 shuffle=3326748311
   libbpf.h:1262:16: note: previous declaration of 'bpf_map__make_exclusive' with type 'int(struct bpf_map *, struct bpf_program *)'
    1262 | LIBBPF_API int bpf_map__make_exclusive(struct bpf_map *map, struct bpf_program *prog);
         |                ^~~~~~~~~~~~~~~~~~~~~~~
   cc1: all warnings being treated as errors
   make[6]: *** [tools/build/Makefile.build:85: tools/bpf/resolve_btfids/libbpf/staticobjs/strset.o] Error 1 shuffle=3326748311
   cc1: all warnings being treated as errors
   make[6]: *** [tools/build/Makefile.build:85: tools/bpf/resolve_btfids/libbpf/staticobjs/btf_iter.o] Error 1 shuffle=3326748311
   cc1: all warnings being treated as errors
   make[6]: *** [tools/build/Makefile.build:85: tools/bpf/resolve_btfids/libbpf/staticobjs/bpf_prog_linfo.o] Error 1 shuffle=3326748311
   cc1: all warnings being treated as errors
   make[6]: *** [tools/build/Makefile.build:85: tools/bpf/resolve_btfids/libbpf/staticobjs/zip.o] Error 1 shuffle=3326748311
   cc1: all warnings being treated as errors
   make[6]: *** [tools/build/Makefile.build:85: tools/bpf/resolve_btfids/libbpf/staticobjs/libbpf_probes.o] Error 1 shuffle=3326748311
   cc1: all warnings being treated as errors
   make[6]: *** [tools/build/Makefile.build:85: tools/bpf/resolve_btfids/libbpf/staticobjs/elf.o] Error 1 shuffle=3326748311
   cc1: all warnings being treated as errors
   make[6]: *** [tools/build/Makefile.build:85: tools/bpf/resolve_btfids/libbpf/staticobjs/btf_relocate.o] Error 1 shuffle=3326748311
   cc1: all warnings being treated as errors
   cc1: all warnings being treated as errors
   make[6]: *** [tools/build/Makefile.build:85: tools/bpf/resolve_btfids/libbpf/staticobjs/features.o] Error 1 shuffle=3326748311
   make[6]: *** [tools/build/Makefile.build:85: tools/bpf/resolve_btfids/libbpf/staticobjs/ringbuf.o] Error 1 shuffle=3326748311
   cc1: all warnings being treated as errors
   make[6]: *** [tools/build/Makefile.build:85: tools/bpf/resolve_btfids/libbpf/staticobjs/netlink.o] Error 1 shuffle=3326748311
   cc1: all warnings being treated as errors
   make[6]: *** [tools/build/Makefile.build:85: tools/bpf/resolve_btfids/libbpf/staticobjs/usdt.o] Error 1 shuffle=3326748311
   cc1: all warnings being treated as errors
   cc1: all warnings being treated as errors
   make[6]: *** [tools/build/Makefile.build:85: tools/bpf/resolve_btfids/libbpf/staticobjs/gen_loader.o] Error 1 shuffle=3326748311
   make[6]: *** [tools/build/Makefile.build:85: tools/bpf/resolve_btfids/libbpf/staticobjs/relo_core.o] Error 1 shuffle=3326748311
   cc1: all warnings being treated as errors
   make[6]: *** [tools/build/Makefile.build:85: tools/bpf/resolve_btfids/libbpf/staticobjs/btf_dump.o] Error 1 shuffle=3326748311
   cc1: all warnings being treated as errors
   make[6]: *** [tools/build/Makefile.build:85: tools/bpf/resolve_btfids/libbpf/staticobjs/bpf.o] Error 1 shuffle=3326748311
   cc1: all warnings being treated as errors
   make[6]: *** [tools/build/Makefile.build:85: tools/bpf/resolve_btfids/libbpf/staticobjs/linker.o] Error 1 shuffle=3326748311
   cc1: all warnings being treated as errors
   make[6]: *** [tools/build/Makefile.build:85: tools/bpf/resolve_btfids/libbpf/staticobjs/btf.o] Error 1 shuffle=3326748311
   cc1: all warnings being treated as errors
   make[6]: *** [tools/build/Makefile.build:85: tools/bpf/resolve_btfids/libbpf/staticobjs/libbpf.o] Error 1 shuffle=3326748311
   make[6]: Target '__build' not remade because of errors.
   make[5]: *** [Makefile:152: tools/bpf/resolve_btfids/libbpf/staticobjs/libbpf-in.o] Error 2 shuffle=3326748311
   make[5]: Target 'tools/bpf/resolve_btfids/libbpf/libbpf.a' not remade because of errors.
   make[4]: *** [Makefile:61: tools/bpf/resolve_btfids//libbpf/libbpf.a] Error 2 shuffle=3326748311
   make[4]: Target 'all' not remade because of errors.
   make[3]: *** [Makefile:76: bpf/resolve_btfids] Error 2 shuffle=3326748311
   make[2]: *** [Makefile:1448: tools/bpf/resolve_btfids] Error 2 shuffle=3326748311
   make[2]: Target 'prepare' not remade because of errors.
   make[1]: *** [Makefile:248: __sub-make] Error 2 shuffle=3326748311
   make[1]: Target 'prepare' not remade because of errors.
   make: *** [Makefile:248: __sub-make] Error 2 shuffle=3326748311
   make: Target 'prepare' not remade because of errors.

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

