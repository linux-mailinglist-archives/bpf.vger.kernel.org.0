Return-Path: <bpf+bounces-48661-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 96FA5A0ACD1
	for <lists+bpf@lfdr.de>; Mon, 13 Jan 2025 01:29:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C47BE1886525
	for <lists+bpf@lfdr.de>; Mon, 13 Jan 2025 00:29:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E7D5BA49;
	Mon, 13 Jan 2025 00:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gNKV+flh"
X-Original-To: bpf@vger.kernel.org
Received: from mail-il1-f171.google.com (mail-il1-f171.google.com [209.85.166.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 058788493;
	Mon, 13 Jan 2025 00:28:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736728141; cv=none; b=LDsJ/R+crQLEHQID7WCbp1AoHvFwbVkj7jPJoWyXQA8HJEytdfDAUKY+zGlirUnj3xEsvlMAWt/4Rdg3dUvAlUKT7dMtUwgUQRZSbre3rXlJ1ptxrg3K7v0PAi+AJm8NEas86mamEksBQFhzAL9poclwre1DvdmAvkjLRxKTPAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736728141; c=relaxed/simple;
	bh=zUSPp3Hj/TjNZyXxqb8EAXhc1jPbu3S7uH04LyhF3Cg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=olhtEsTFiKC9YoP7CINb32JJQoKh9Sa+dJwwg/0nQdynYBRUdu0iiRJ0i+mD2UOOODi46WGVHFw/BWOH2SgspMRKNRubz3YZTOHQ6hFBKm408HQAMdET/WI1f43IRKACjCv+SmoSYTQAbFkFRrk9Ys1opf6sGobTmKbikCyw8KQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gNKV+flh; arc=none smtp.client-ip=209.85.166.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f171.google.com with SMTP id e9e14a558f8ab-3a9caa3726fso12275535ab.1;
        Sun, 12 Jan 2025 16:28:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736728138; x=1737332938; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k1xOA/SQ8iALm8MjEJqxz2Y25Nhzv2dANUJoHZQZb/w=;
        b=gNKV+flhgKYyY6VnRK5TTd0KyoVJXOuGC+Q7GZB0SwRoTQ1dyHvkCIGlwqTsy9NNas
         qfJFztiCfiOZmco5tmpstN+RCPD2eD7XX+/0W4hFy/1iML9dbL7NgZjdVjyG/5uLXWD8
         iciIsVFwHPcYq9V9PTwExjYTlROiipn/grUmHAOGxqE/z4DAnVpdDLtzaXDF+e5H+Gxh
         ArCF+ORbI6KWHJLtawwDH8ZfYbA54HgDMrpWnfQBRU2OvCjc12z/vQX2vU9rqm6Sh4//
         /rBdJ4fVR6rLLpu45SqJKglXJJbqyt7z5piIDHAr5Yxh84QV2r3Ec5IGDHLKtlTYYpRO
         GHzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736728138; x=1737332938;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k1xOA/SQ8iALm8MjEJqxz2Y25Nhzv2dANUJoHZQZb/w=;
        b=r0V7pqgmU6oSwuqSBFjRSTY+RYOj6LZAog9udjBjiUiTjHR1bDraF5JhN1+eHXvW+L
         cCi4DE9JjZA1Dsd+7JLkRSU1jRiCUpPq8ysZWo2K1WUqxC8PwvOSWgu6gMMZiyeYCkyX
         6llGh86VW582gjGi8ZNGl/y9SSFXZCRalD4BvGEJWHnsHAYGt6OYQHg2AIHek5FvCRQ8
         eZmr6cd6oUyrjWTHgNA9MeecIwzzP50go+qK+f+wuAQSbmXj+WTGwdPPeVDJTvgC+YOn
         V5un9xkACigi4SHpz/HltHdsxvQQG1SF386zxNmjOd7gYWQUj7Yp1eZ8wGpVE3I2bWPj
         219w==
X-Forwarded-Encrypted: i=1; AJvYcCUEw+vky4lTBdR5S3mqRGpL1FF/pAwEy3d0H8U02dHvhuUmCtkbyIEPhzI9Zvim9+SQK2w=@vger.kernel.org, AJvYcCUMn3O0r5UN0uI+6gQkZZulbMcbhuGC9n8da7iVMjAsdKwDxkq2JUHWEij0xl2PN/Sk77RK11aK@vger.kernel.org
X-Gm-Message-State: AOJu0YzJt7OrnKlrkz8N4fRI43vyr0jR7DIn5hffSQmTwASQdx85b0Uw
	7/JmGw8aTrbTa81EW/kDTaIzzDY5nDvjGqBcJkKK0C9tqdxDKeSNtDk/e3xVvgZEJ9nWsEq1rov
	jJYsPpv95Bh/7ajWkee7iG9CFmfI=
X-Gm-Gg: ASbGnctmk6N6nlR83dp8CSmJy9JQTjYRXRSoBrh1DPGMj7vbVQjMk2GIWKQ8b8AU3L+
	iiXuDfwPpr0/vEMipgOeKx51jQ+cajAtrzxNSTA==
X-Google-Smtp-Source: AGHT+IEBNwkThVQXNyg9t9dnefMlcVeyifbI2RGhIl71J54yeFuYTxlozCIKeOOetDZW2NlY+QchIanD/FJsU4Ujs84=
X-Received: by 2002:a05:6e02:1605:b0:3ce:3395:f7b1 with SMTP id
 e9e14a558f8ab-3ce475fbc60mr98031725ab.9.1736728138047; Sun, 12 Jan 2025
 16:28:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250112113748.73504-6-kerneljasonxing@gmail.com> <202501122251.7G2Wsbzx-lkp@intel.com>
In-Reply-To: <202501122251.7G2Wsbzx-lkp@intel.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Mon, 13 Jan 2025 08:28:21 +0800
X-Gm-Features: AbW1kvYvkS3KXWZNdtH7afWFQTdG2PQEkkdIbiXvr1BeLeScoU4dex_Q61iCRjk
Message-ID: <CAL+tcoDJfy+SjVKF==fKLVVdr8qE0mJ2WWzGozN4f=OLX6ip1A@mail.gmail.com>
Subject: Re: [PATCH net-next v5 05/15] net-timestamp: add strict check in some
 BPF calls
To: kernel test robot <lkp@intel.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, dsahern@kernel.org, willemdebruijn.kernel@gmail.com, 
	willemb@google.com, ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org, 
	yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org, 
	sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, horms@kernel.org, 
	llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev, bpf@vger.kernel.org, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jan 12, 2025 at 10:39=E2=80=AFPM kernel test robot <lkp@intel.com> =
wrote:
>
> Hi Jason,
>
> kernel test robot noticed the following build warnings:
>
> [auto build test WARNING on net-next/main]
>
> url:    https://github.com/intel-lab-lkp/linux/commits/Jason-Xing/net-tim=
estamp-add-support-for-bpf_setsockopt/20250112-194115
> base:   net-next/main
> patch link:    https://lore.kernel.org/r/20250112113748.73504-6-kerneljas=
onxing%40gmail.com
> patch subject: [PATCH net-next v5 05/15] net-timestamp: add strict check =
in some BPF calls
> config: i386-buildonly-randconfig-006-20250112 (https://download.01.org/0=
day-ci/archive/20250112/202501122251.7G2Wsbzx-lkp@intel.com/config)
> compiler: clang version 19.1.3 (https://github.com/llvm/llvm-project ab51=
eccf88f5321e7c60591c5546b254b6afab99)
> reproduce (this is a W=3D1 build): (https://download.01.org/0day-ci/archi=
ve/20250112/202501122251.7G2Wsbzx-lkp@intel.com/reproduce)
>
> If you fix the issue in a separate patch/commit (i.e. not just a new vers=
ion of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202501122251.7G2Wsbzx-lkp=
@intel.com/
>
> All warnings (new ones prefixed by >>):
>
>          |                           ~~~~~~~~~~~~~~ ^ ~~~~~~~~~~
>    net/core/filter.c:4863:30: warning: bitwise operation between differen=
t enumeration types ('enum bpf_arg_type' and 'enum bpf_type_flag') [-Wenum-=
enum-conversion]
>     4863 |         .arg2_type      =3D ARG_PTR_TO_MEM | MEM_RDONLY,
>          |                           ~~~~~~~~~~~~~~ ^ ~~~~~~~~~~
>    net/core/filter.c:4891:30: warning: bitwise operation between differen=
t enumeration types ('enum bpf_arg_type' and 'enum bpf_type_flag') [-Wenum-=
enum-conversion]
>     4891 |         .arg2_type      =3D ARG_PTR_TO_MEM | MEM_RDONLY,
>          |                           ~~~~~~~~~~~~~~ ^ ~~~~~~~~~~
>    net/core/filter.c:5063:30: warning: bitwise operation between differen=
t enumeration types ('enum bpf_arg_type' and 'enum bpf_type_flag') [-Wenum-=
enum-conversion]
>     5063 |         .arg4_type      =3D ARG_PTR_TO_MEM | MEM_RDONLY,
>          |                           ~~~~~~~~~~~~~~ ^ ~~~~~~~~~~
>    net/core/filter.c:5077:30: warning: bitwise operation between differen=
t enumeration types ('enum bpf_arg_type' and 'enum bpf_type_flag') [-Wenum-=
enum-conversion]
>     5077 |         .arg4_type      =3D ARG_PTR_TO_MEM | MEM_RDONLY,
>          |                           ~~~~~~~~~~~~~~ ^ ~~~~~~~~~~
>    net/core/filter.c:5126:45: warning: bitwise operation between differen=
t enumeration types ('enum bpf_arg_type' and 'enum bpf_type_flag') [-Wenum-=
enum-conversion]
>     5126 |         .arg1_type      =3D ARG_PTR_TO_BTF_ID_SOCK_COMMON | PT=
R_MAYBE_NULL,
>          |                           ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ ^ ~~~~=
~~~~~~~~~~
>    net/core/filter.c:5592:30: warning: bitwise operation between differen=
t enumeration types ('enum bpf_arg_type' and 'enum bpf_type_flag') [-Wenum-=
enum-conversion]
>     5592 |         .arg4_type      =3D ARG_PTR_TO_MEM | MEM_RDONLY,
>          |                           ~~~~~~~~~~~~~~ ^ ~~~~~~~~~~
>    net/core/filter.c:5626:30: warning: bitwise operation between differen=
t enumeration types ('enum bpf_arg_type' and 'enum bpf_type_flag') [-Wenum-=
enum-conversion]
>     5626 |         .arg4_type      =3D ARG_PTR_TO_MEM | MEM_RDONLY,
>          |                           ~~~~~~~~~~~~~~ ^ ~~~~~~~~~~
>    net/core/filter.c:5660:30: warning: bitwise operation between differen=
t enumeration types ('enum bpf_arg_type' and 'enum bpf_type_flag') [-Wenum-=
enum-conversion]
>     5660 |         .arg4_type      =3D ARG_PTR_TO_MEM | MEM_RDONLY,
>          |                           ~~~~~~~~~~~~~~ ^ ~~~~~~~~~~
>    net/core/filter.c:5703:30: warning: bitwise operation between differen=
t enumeration types ('enum bpf_arg_type' and 'enum bpf_type_flag') [-Wenum-=
enum-conversion]
>     5703 |         .arg4_type      =3D ARG_PTR_TO_MEM | MEM_RDONLY,
>          |                           ~~~~~~~~~~~~~~ ^ ~~~~~~~~~~
>    net/core/filter.c:5880:30: warning: bitwise operation between differen=
t enumeration types ('enum bpf_arg_type' and 'enum bpf_type_flag') [-Wenum-=
enum-conversion]
>     5880 |         .arg2_type      =3D ARG_PTR_TO_MEM | MEM_RDONLY,
>          |                           ~~~~~~~~~~~~~~ ^ ~~~~~~~~~~
>    net/core/filter.c:6417:46: warning: bitwise operation between differen=
t enumeration types ('enum bpf_arg_type' and 'enum bpf_type_flag') [-Wenum-=
enum-conversion]
>     6417 |         .arg3_type      =3D ARG_PTR_TO_FIXED_SIZE_MEM | MEM_WR=
ITE | MEM_ALIGNED,
>          |                           ~~~~~~~~~~~~~~~~~~~~~~~~~ ^ ~~~~~~~~=
~
>    net/core/filter.c:6429:46: warning: bitwise operation between differen=
t enumeration types ('enum bpf_arg_type' and 'enum bpf_type_flag') [-Wenum-=
enum-conversion]
>     6429 |         .arg3_type      =3D ARG_PTR_TO_FIXED_SIZE_MEM | MEM_WR=
ITE | MEM_ALIGNED,
>          |                           ~~~~~~~~~~~~~~~~~~~~~~~~~ ^ ~~~~~~~~=
~
>    net/core/filter.c:6515:30: warning: bitwise operation between differen=
t enumeration types ('enum bpf_arg_type' and 'enum bpf_type_flag') [-Wenum-=
enum-conversion]
>     6515 |         .arg3_type      =3D ARG_PTR_TO_MEM | MEM_RDONLY,
>          |                           ~~~~~~~~~~~~~~ ^ ~~~~~~~~~~
>    net/core/filter.c:6525:30: warning: bitwise operation between differen=
t enumeration types ('enum bpf_arg_type' and 'enum bpf_type_flag') [-Wenum-=
enum-conversion]
>     6525 |         .arg3_type      =3D ARG_PTR_TO_MEM | MEM_RDONLY,
>          |                           ~~~~~~~~~~~~~~ ^ ~~~~~~~~~~
>    net/core/filter.c:6569:30: warning: bitwise operation between differen=
t enumeration types ('enum bpf_arg_type' and 'enum bpf_type_flag') [-Wenum-=
enum-conversion]
>     6569 |         .arg3_type      =3D ARG_PTR_TO_MEM | MEM_RDONLY,
>          |                           ~~~~~~~~~~~~~~ ^ ~~~~~~~~~~
>    net/core/filter.c:6658:30: warning: bitwise operation between differen=
t enumeration types ('enum bpf_arg_type' and 'enum bpf_type_flag') [-Wenum-=
enum-conversion]
>     6658 |         .arg3_type      =3D ARG_PTR_TO_MEM | MEM_RDONLY,
>          |                           ~~~~~~~~~~~~~~ ^ ~~~~~~~~~~
>    net/core/filter.c:6902:30: warning: bitwise operation between differen=
t enumeration types ('enum bpf_arg_type' and 'enum bpf_type_flag') [-Wenum-=
enum-conversion]
>     6902 |         .arg2_type      =3D ARG_PTR_TO_MEM | MEM_RDONLY,
>          |                           ~~~~~~~~~~~~~~ ^ ~~~~~~~~~~
>    net/core/filter.c:6921:30: warning: bitwise operation between differen=
t enumeration types ('enum bpf_arg_type' and 'enum bpf_type_flag') [-Wenum-=
enum-conversion]
>     6921 |         .arg2_type      =3D ARG_PTR_TO_MEM | MEM_RDONLY,
>          |                           ~~~~~~~~~~~~~~ ^ ~~~~~~~~~~
>    net/core/filter.c:6940:30: warning: bitwise operation between differen=
t enumeration types ('enum bpf_arg_type' and 'enum bpf_type_flag') [-Wenum-=
enum-conversion]
>     6940 |         .arg2_type      =3D ARG_PTR_TO_MEM | MEM_RDONLY,
>          |                           ~~~~~~~~~~~~~~ ^ ~~~~~~~~~~
>    net/core/filter.c:6964:30: warning: bitwise operation between differen=
t enumeration types ('enum bpf_arg_type' and 'enum bpf_type_flag') [-Wenum-=
enum-conversion]
>     6964 |         .arg2_type      =3D ARG_PTR_TO_MEM | MEM_RDONLY,
>          |                           ~~~~~~~~~~~~~~ ^ ~~~~~~~~~~
>    net/core/filter.c:6988:30: warning: bitwise operation between differen=
t enumeration types ('enum bpf_arg_type' and 'enum bpf_type_flag') [-Wenum-=
enum-conversion]
>     6988 |         .arg2_type      =3D ARG_PTR_TO_MEM | MEM_RDONLY,
>          |                           ~~~~~~~~~~~~~~ ^ ~~~~~~~~~~
>    net/core/filter.c:7012:30: warning: bitwise operation between differen=
t enumeration types ('enum bpf_arg_type' and 'enum bpf_type_flag') [-Wenum-=
enum-conversion]
>     7012 |         .arg2_type      =3D ARG_PTR_TO_MEM | MEM_RDONLY,
>          |                           ~~~~~~~~~~~~~~ ^ ~~~~~~~~~~
>    net/core/filter.c:7029:45: warning: bitwise operation between differen=
t enumeration types ('enum bpf_arg_type' and 'enum bpf_type_flag') [-Wenum-=
enum-conversion]
>     7029 |         .arg1_type      =3D ARG_PTR_TO_BTF_ID_SOCK_COMMON | OB=
J_RELEASE,
>          |                           ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ ^ ~~~~=
~~~~~~~
>    net/core/filter.c:7050:35: warning: bitwise operation between differen=
t enumeration types ('enum bpf_arg_type' and 'enum bpf_type_flag') [-Wenum-=
enum-conversion]
>     7050 |         .arg2_type      =3D ARG_PTR_TO_MEM | MEM_RDONLY,
>          |                           ~~~~~~~~~~~~~~ ^ ~~~~~~~~~~
>    net/core/filter.c:7074:35: warning: bitwise operation between differen=
t enumeration types ('enum bpf_arg_type' and 'enum bpf_type_flag') [-Wenum-=
enum-conversion]
>     7074 |         .arg2_type      =3D ARG_PTR_TO_MEM | MEM_RDONLY,
>          |                           ~~~~~~~~~~~~~~ ^ ~~~~~~~~~~
>    net/core/filter.c:7098:35: warning: bitwise operation between differen=
t enumeration types ('enum bpf_arg_type' and 'enum bpf_type_flag') [-Wenum-=
enum-conversion]
>     7098 |         .arg2_type      =3D ARG_PTR_TO_MEM | MEM_RDONLY,
>          |                           ~~~~~~~~~~~~~~ ^ ~~~~~~~~~~
>    net/core/filter.c:7118:30: warning: bitwise operation between differen=
t enumeration types ('enum bpf_arg_type' and 'enum bpf_type_flag') [-Wenum-=
enum-conversion]
>     7118 |         .arg2_type      =3D ARG_PTR_TO_MEM | MEM_RDONLY,
>          |                           ~~~~~~~~~~~~~~ ^ ~~~~~~~~~~
>    net/core/filter.c:7137:30: warning: bitwise operation between differen=
t enumeration types ('enum bpf_arg_type' and 'enum bpf_type_flag') [-Wenum-=
enum-conversion]
>     7137 |         .arg2_type      =3D ARG_PTR_TO_MEM | MEM_RDONLY,
>          |                           ~~~~~~~~~~~~~~ ^ ~~~~~~~~~~
>    net/core/filter.c:7156:30: warning: bitwise operation between differen=
t enumeration types ('enum bpf_arg_type' and 'enum bpf_type_flag') [-Wenum-=
enum-conversion]
>     7156 |         .arg2_type      =3D ARG_PTR_TO_MEM | MEM_RDONLY,
>          |                           ~~~~~~~~~~~~~~ ^ ~~~~~~~~~~
>    net/core/filter.c:7474:30: warning: bitwise operation between differen=
t enumeration types ('enum bpf_arg_type' and 'enum bpf_type_flag') [-Wenum-=
enum-conversion]
>     7474 |         .arg2_type      =3D ARG_PTR_TO_MEM | MEM_RDONLY,
>          |                           ~~~~~~~~~~~~~~ ^ ~~~~~~~~~~
>    net/core/filter.c:7476:30: warning: bitwise operation between differen=
t enumeration types ('enum bpf_arg_type' and 'enum bpf_type_flag') [-Wenum-=
enum-conversion]
>     7476 |         .arg4_type      =3D ARG_PTR_TO_MEM | MEM_RDONLY,
>          |                           ~~~~~~~~~~~~~~ ^ ~~~~~~~~~~
>    net/core/filter.c:7543:30: warning: bitwise operation between differen=
t enumeration types ('enum bpf_arg_type' and 'enum bpf_type_flag') [-Wenum-=
enum-conversion]
>     7543 |         .arg2_type      =3D ARG_PTR_TO_MEM | MEM_RDONLY,
>          |                           ~~~~~~~~~~~~~~ ^ ~~~~~~~~~~
>    net/core/filter.c:7545:30: warning: bitwise operation between differen=
t enumeration types ('enum bpf_arg_type' and 'enum bpf_type_flag') [-Wenum-=
enum-conversion]
>     7545 |         .arg4_type      =3D ARG_PTR_TO_MEM | MEM_RDONLY,
>          |                           ~~~~~~~~~~~~~~ ^ ~~~~~~~~~~
> >> net/core/filter.c:7631:19: warning: result of comparison of constant '=
SK_BPF_CB_FLAGS' (1009) with expression of type 'u8' (aka 'unsigned char') =
is always true [-Wtautological-constant-out-of-range-compare]
>     7631 |         if (bpf_sock->op !=3D SK_BPF_CB_FLAGS)
>          |             ~~~~~~~~~~~~ ^  ~~~~~~~~~~~~~~~
>    net/core/filter.c:7777:30: warning: bitwise operation between differen=
t enumeration types ('enum bpf_arg_type' and 'enum bpf_type_flag') [-Wenum-=
enum-conversion]
>     7777 |         .arg2_type      =3D ARG_PTR_TO_MEM | MEM_RDONLY,
>          |                           ~~~~~~~~~~~~~~ ^ ~~~~~~~~~~
>    41 warnings generated.
>
>
> vim +7631 net/core/filter.c
>
>   7622
>   7623  BPF_CALL_4(bpf_sock_ops_load_hdr_opt, struct bpf_sock_ops_kern *,=
 bpf_sock,
>   7624             void *, search_res, u32, len, u64, flags)
>   7625  {
>   7626          bool eol, load_syn =3D flags & BPF_LOAD_HDR_OPT_TCP_SYN;
>   7627          const u8 *op, *opend, *magic, *search =3D search_res;
>   7628          u8 search_kind, search_len, copy_len, magic_len;
>   7629          int ret;
>   7630
> > 7631          if (bpf_sock->op !=3D SK_BPF_CB_FLAGS)

Oops, I realized that SK_BPF_CB_FLAGS cannot be used by "op". I'll
aggregate all the callbacks used by timestamping and use to test them
here like the following patch to avoid calling these helpers in the
context of timestamping callback.

diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index 87420c0f2235..9e6a782b4042 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -7022,6 +7022,10 @@ enum {
                                         * by the kernel or the
                                         * earlier bpf-progs.
                                         */
+#define BPF_SOCK_OPTS_TS               (BPF_SOCK_OPS_TS_SCHED_OPT_CB | \
+                                        BPF_SOCK_OPS_TS_SW_OPT_CB | \
+                                        BPF_SOCK_OPS_TS_ACK_OPT_CB | \
+                                        BPF_SOCK_OPS_TS_TCP_SND_CB)
        BPF_SOCK_OPS_TS_SCHED_OPT_CB,   /* Called when skb is passing throu=
gh
                                         * dev layer when SO_TIMESTAMPING
                                         * feature is on. It indicates the
diff --git a/net/core/filter.c b/net/core/filter.c
index 517f09aabc92..1fcd88b558f4 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -7628,7 +7628,7 @@ BPF_CALL_4(bpf_sock_ops_load_hdr_opt, struct
bpf_sock_ops_kern *, bpf_sock,
        u8 search_kind, search_len, copy_len, magic_len;
        int ret;

-       if (bpf_sock->op !=3D SK_BPF_CB_FLAGS)
+       if (bpf_sock->op !=3D BPF_SOCK_OPTS_TS)
                return -EINVAL;

        /* 2 byte is the minimal option len except TCPOPT_NOP and

Thanks,
Jason

>   7632                  return -EINVAL;
>   7633
>   7634          /* 2 byte is the minimal option len except TCPOPT_NOP and
>   7635           * TCPOPT_EOL which are useless for the bpf prog to learn
>   7636           * and this helper disallow loading them also.
>   7637           */
>   7638          if (len < 2 || flags & ~BPF_LOAD_HDR_OPT_TCP_SYN)
>   7639                  return -EINVAL;
>   7640
>   7641          search_kind =3D search[0];
>   7642          search_len =3D search[1];
>   7643
>   7644          if (search_len > len || search_kind =3D=3D TCPOPT_NOP ||
>   7645              search_kind =3D=3D TCPOPT_EOL)
>   7646                  return -EINVAL;
>   7647
>   7648          if (search_kind =3D=3D TCPOPT_EXP || search_kind =3D=3D 2=
53) {
>   7649                  /* 16 or 32 bit magic.  +2 for kind and kind leng=
th */
>   7650                  if (search_len !=3D 4 && search_len !=3D 6)
>   7651                          return -EINVAL;
>   7652                  magic =3D &search[2];
>   7653                  magic_len =3D search_len - 2;
>   7654          } else {
>   7655                  if (search_len)
>   7656                          return -EINVAL;
>   7657                  magic =3D NULL;
>   7658                  magic_len =3D 0;
>   7659          }
>   7660
>   7661          if (load_syn) {
>   7662                  ret =3D bpf_sock_ops_get_syn(bpf_sock, TCP_BPF_SY=
N, &op);
>   7663                  if (ret < 0)
>   7664                          return ret;
>   7665
>   7666                  opend =3D op + ret;
>   7667                  op +=3D sizeof(struct tcphdr);
>   7668          } else {
>   7669                  if (!bpf_sock->skb ||
>   7670                      bpf_sock->op =3D=3D BPF_SOCK_OPS_HDR_OPT_LEN_=
CB)
>   7671                          /* This bpf_sock->op cannot call this hel=
per */
>   7672                          return -EPERM;
>   7673
>   7674                  opend =3D bpf_sock->skb_data_end;
>   7675                  op =3D bpf_sock->skb->data + sizeof(struct tcphdr=
);
>   7676          }
>   7677
>   7678          op =3D bpf_search_tcp_opt(op, opend, search_kind, magic, =
magic_len,
>   7679                                  &eol);
>   7680          if (IS_ERR(op))
>   7681                  return PTR_ERR(op);
>   7682
>   7683          copy_len =3D op[1];
>   7684          ret =3D copy_len;
>   7685          if (copy_len > len) {
>   7686                  ret =3D -ENOSPC;
>   7687                  copy_len =3D len;
>   7688          }
>   7689
>   7690          memcpy(search_res, op, copy_len);
>   7691          return ret;
>   7692  }
>   7693
>
> --
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests/wiki

