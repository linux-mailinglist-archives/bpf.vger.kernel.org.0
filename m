Return-Path: <bpf+bounces-33046-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E79C91657E
	for <lists+bpf@lfdr.de>; Tue, 25 Jun 2024 12:47:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B3EA2B228E9
	for <lists+bpf@lfdr.de>; Tue, 25 Jun 2024 10:47:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCD5314A4D9;
	Tue, 25 Jun 2024 10:47:03 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from albert.telenet-ops.be (albert.telenet-ops.be [195.130.137.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BDDF1311A3
	for <bpf@vger.kernel.org>; Tue, 25 Jun 2024 10:46:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.130.137.90
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719312423; cv=none; b=a5iLCegn7WR6Dxv2POaJ0n1kwj333qO+dkaMyanZIJ7rLckMH1vEHokOIoHYi8Z/WJvOA0mM820kMXjhY25C71KSgjanvTFRF+K7q3FaVpGooW5sgBQgjQuyO6sQgZsPoaY/IHexkxsm2oNU7WevoyOg1R9TVEhp12tK76v86bw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719312423; c=relaxed/simple;
	bh=Gws9Yyiaiqmrq1E8aExJybewGObcu5HH/sCBZ3vRlmA=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=BccxSpWCaeSC7MN6drRQrzy6zcy48vwKe05mN0HJhM1pb+F4Ydkyvd2KnULxlXx3sLqp9+65K3bnnBlSV1Rk/fVfKcEeYnNPQIkv3qn574t4+PSOWX+UeDrYPXEHPyaZguGG76mWTcHaMYFjNC07WCBFuJ/nfnriTG4A0O+zOdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=none smtp.mailfrom=linux-m68k.org; arc=none smtp.client-ip=195.130.137.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed80:4e71:737f:f905:c457])
	by albert.telenet-ops.be with bizsmtp
	id fmmo2C00F5EKelT06mmo3C; Tue, 25 Jun 2024 12:46:58 +0200
Received: from geert (helo=localhost)
	by ramsan.of.borg with local-esmtp (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1sM3hI-000Kn6-Js;
	Tue, 25 Jun 2024 12:46:48 +0200
Date: Tue, 25 Jun 2024 12:46:48 +0200 (CEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Tony Ambardar <tony.ambardar@gmail.com>
cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
    Daniel Borkmann <daniel@iogearbox.net>, 
    Andrii Nakryiko <andrii@kernel.org>, 
    Martin KaFai Lau <martin.lau@linux.dev>, 
    Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
    Yonghong Song <yonghong.song@linux.dev>, 
    John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
    Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, 
    Jiri Olsa <jolsa@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, 
    kernel test robot <lkp@intel.com>, stable@vger.kernel.org, 
    Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH bpf v2 2/2] bpf: Harden __bpf_kfunc tag against linker
 kfunc removal
In-Reply-To: <e9c64e9b5c073dabd457ff45128aabcab7630098.1717477560.git.Tony.Ambardar@gmail.com>
Message-ID: <51bc27e-f073-f6f7-df63-f9bbf96e2024@linux-m68k.org>
References: <cover.1717413886.git.Tony.Ambardar@gmail.com> <cover.1717477560.git.Tony.Ambardar@gmail.com> <e9c64e9b5c073dabd457ff45128aabcab7630098.1717477560.git.Tony.Ambardar@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1492989470-1719312408=:79904"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1492989470-1719312408=:79904
Content-Type: text/plain; charset=ISO-8859-7; format=flowed
Content-Transfer-Encoding: 8BIT

 	Hi Tony,

On Mon, 3 Jun 2024, Tony Ambardar wrote:
> BPF kfuncs are often not directly referenced and may be inadvertently
> removed by optimization steps during kernel builds, thus the __bpf_kfunc
> tag mitigates against this removal by including the __used macro. However,
> this macro alone does not prevent removal during linking, and may still
> yield build warnings (e.g. on mips64el):
>
>    LD      vmlinux
>    BTFIDS  vmlinux
>  WARN: resolve_btfids: unresolved symbol bpf_verify_pkcs7_signature
>  WARN: resolve_btfids: unresolved symbol bpf_lookup_user_key
>  WARN: resolve_btfids: unresolved symbol bpf_lookup_system_key
>  WARN: resolve_btfids: unresolved symbol bpf_key_put
>  WARN: resolve_btfids: unresolved symbol bpf_iter_task_next
>  WARN: resolve_btfids: unresolved symbol bpf_iter_css_task_new
>  WARN: resolve_btfids: unresolved symbol bpf_get_file_xattr
>  WARN: resolve_btfids: unresolved symbol bpf_ct_insert_entry
>  WARN: resolve_btfids: unresolved symbol bpf_cgroup_release
>  WARN: resolve_btfids: unresolved symbol bpf_cgroup_from_id
>  WARN: resolve_btfids: unresolved symbol bpf_cgroup_acquire
>  WARN: resolve_btfids: unresolved symbol bpf_arena_free_pages
>    NM      System.map
>    SORTTAB vmlinux
>    OBJCOPY vmlinux.32
>
> Update the __bpf_kfunc tag to better guard against linker optimization by
> including the new __retain compiler macro, which fixes the warnings above.
>
> Verify the __retain macro with readelf by checking object flags for 'R':
>
>  $ readelf -Wa kernel/trace/bpf_trace.o
>  Section Headers:
>    [Nr]  Name              Type     Address  Off  Size ES Flg Lk Inf Al
>  ...
>    [178] .text.bpf_key_put PROGBITS 00000000 6420 0050 00 AXR  0   0  8
>  ...
>  Key to Flags:
>  ...
>    R (retain), D (mbind), p (processor specific)
>
> Link: https://lore.kernel.org/bpf/ZlmGoT9KiYLZd91S@krava/T/
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/r/202401211357.OCX9yllM-lkp@intel.com/
> Fixes: 57e7c169cd6a ("bpf: Add __bpf_kfunc tag for marking kernel functions as kfuncs")
> Cc: stable@vger.kernel.org # v6.6+
> Signed-off-by: Tony Ambardar <Tony.Ambardar@gmail.com>

Thanks for your patch, which is now commit 7bdcedd5c8fb88e7
("bpf: Harden __bpf_kfunc tag against linker kfunc removal") in
v6.10-rc5.

This is causing build failures on ARM with
CONFIG_LD_DEAD_CODE_DATA_ELIMINATION=y:

     net/core/filter.c:11859:1: error: ¡retain¢ attribute ignored [-Werror=attributes]
     11859 | {
           | ^
     net/core/filter.c:11872:1: error: ¡retain¢ attribute ignored [-Werror=attributes]
     11872 | {
           | ^
     net/core/filter.c:11885:1: error: ¡retain¢ attribute ignored [-Werror=attributes]
     11885 | {
           | ^
     net/core/filter.c:11906:1: error: ¡retain¢ attribute ignored [-Werror=attributes]
     11906 | {
           | ^
     net/core/filter.c:12092:1: error: ¡retain¢ attribute ignored [-Werror=attributes]
     12092 | {
           | ^
     net/core/xdp.c:713:1: error: ¡retain¢ attribute ignored [-Werror=attributes]
       713 | {
           | ^
     net/core/xdp.c:736:1: error: ¡retain¢ attribute ignored [-Werror=attributes]
       736 | {
           | ^
     net/core/xdp.c:769:1: error: ¡retain¢ attribute ignored [-Werror=attributes]
       769 | {
           | ^
     [...]

My compiler is arm-linux-gnueabihf-gcc version 11.4.0 (Ubuntu 11.4.0-1ubuntu1~22.04).

> --- a/include/linux/btf.h
> +++ b/include/linux/btf.h
> @@ -82,7 +82,7 @@
>  * as to avoid issues such as the compiler inlining or eliding either a static
>  * kfunc, or a global kfunc in an LTO build.
>  */
> -#define __bpf_kfunc __used noinline
> +#define __bpf_kfunc __used __retain noinline
>
> #define __bpf_kfunc_start_defs()					       \
> 	__diag_push();							       \

Gr{oetje,eeting}s,

 						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
 							    -- Linus Torvalds
--8323329-1492989470-1719312408=:79904--

