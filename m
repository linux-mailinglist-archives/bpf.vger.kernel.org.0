Return-Path: <bpf+bounces-66400-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6527CB34614
	for <lists+bpf@lfdr.de>; Mon, 25 Aug 2025 17:42:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 230443ABE08
	for <lists+bpf@lfdr.de>; Mon, 25 Aug 2025 15:42:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C6C22FDC31;
	Mon, 25 Aug 2025 15:42:28 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B15541C8603;
	Mon, 25 Aug 2025 15:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756136548; cv=none; b=lcoaNTv+lgGn3ffIAONqsO7A+fbz15N6d/e8iWNzITt3S4lHd/YWdS3YUVVxPcz8mW/qUOnY2HxOSVT9h7eFUdDRTUKvu3E1IW/ibjLsAEIHVBodLcfVpV0hDg2/3pP8rBCyDeMxnjPTK7yFySQAZqCi7JOIUtZQ2zc3Dtq+L2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756136548; c=relaxed/simple;
	bh=3u5Br2iEr49BAHcbnjJmPH/soMJdzhQid5e3cp6Hbbw=;
	h=Message-ID:Date:MIME-Version:From:To:Cc:Subject:Content-Type; b=aYmY4PS/GL4+2/Ee/uYBCXXbEsdJTJsnGvsIihOQRl+G6TdjU+uuqKgdry3hkPPbsBFkZESDTqdyUIlr1lI+zKNVKfUwIFY4EH0emAddUweOnpxAcmM6SZyP8YH+uJKHplhEeNYZQijUfFd1ahZh5uWPiqFdeiRq82xjje3MNtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [141.14.220.42] (g42.guest.molgen.mpg.de [141.14.220.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id 836086028825F;
	Mon, 25 Aug 2025 17:42:05 +0200 (CEST)
Message-ID: <15bcb208-3ccb-4d99-853b-545626914373@molgen.mpg.de>
Date: Mon, 25 Aug 2025 17:42:05 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
To: Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: How to deal with increased install size with
 `CONFIG_DEBUG_INFO_BTF=y`
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Dear Linux folks,


Trying to get ptcpdump [1] running, I needed to build Linux with BTF 
symbols.

```
@@ -5985,11 +5986,22 @@
  #
  # Compile-time checks and compiler options
  #
+CONFIG_DEBUG_INFO=y
  CONFIG_AS_HAS_NON_CONST_ULEB128=y
-CONFIG_DEBUG_INFO_NONE=y
+# CONFIG_DEBUG_INFO_NONE is not set
  # CONFIG_DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT is not set
  # CONFIG_DEBUG_INFO_DWARF4 is not set
-# CONFIG_DEBUG_INFO_DWARF5 is not set
+CONFIG_DEBUG_INFO_DWARF5=y
+# CONFIG_DEBUG_INFO_REDUCED is not set
+CONFIG_DEBUG_INFO_COMPRESSED_NONE=y
+# CONFIG_DEBUG_INFO_COMPRESSED_ZLIB is not set
+# CONFIG_DEBUG_INFO_SPLIT is not set
+CONFIG_DEBUG_INFO_BTF=y
+CONFIG_PAHOLE_HAS_SPLIT_BTF=y
+CONFIG_PAHOLE_HAS_LANG_EXCLUDE=y
+CONFIG_DEBUG_INFO_BTF_MODULES=y
+# CONFIG_MODULE_ALLOW_BTF_MISMATCH is not set
+# CONFIG_GDB_SCRIPTS is not set
  CONFIG_FRAME_WARN=2048
  # CONFIG_STRIP_ASM_SYMS is not set
  # CONFIG_READABLE_ASM is not set
```

This increased the module size quite a bit:

     $ du -sh /lib/modules/6.12.4*
     128M        /lib/modules/6.12.40.mx64.484
     1.9G        /lib/modules/6.12.43.mx64.485

Searching the WWW, it was suggested to run `INSTALL_MOD_STRIP=1` [2], 
bringing it down to 137 MB:

     137M        /lib/modules/6.12.43.mx64.486

I was under the expression, that BTF symbols are small compared to the 
debug symbol types from the past. (Excuse my ignorance about the 
terminology and subject.) Is `INSTALL_MOD_STRIP=1` the “recommended” way 
to still use BPF/BTF on production systems.


Kind regards,

Paul


[1]: https://github.com/mozillazg/ptcpdump
[2]: 
https://gitlab.alpinelinux.org/alpine/aports/-/merge_requests/28218/diffs

