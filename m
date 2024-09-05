Return-Path: <bpf+bounces-39053-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 727C696E24D
	for <lists+bpf@lfdr.de>; Thu,  5 Sep 2024 20:52:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8F6C61C2307F
	for <lists+bpf@lfdr.de>; Thu,  5 Sep 2024 18:52:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECAEB188A16;
	Thu,  5 Sep 2024 18:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="S21tY5rN"
X-Original-To: bpf@vger.kernel.org
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03AEF8288C;
	Thu,  5 Sep 2024 18:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725562346; cv=none; b=Dkjakll3P0H5EGGLEUgp0Qv3DyheFR5hCJ6OWUM/5Z+JA0IWGkyvyiXLN61W3murYh8fzCfyIwmh5sFqfdEq3ngXtt+5F0i0p8Uf09eoyM2VgS4kw14A2wCHoTiW56tCo4IB5jKeOSeZnIf3k7XxwfuKrNt8YYgRzE32AoQW4VM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725562346; c=relaxed/simple;
	bh=BdopyJOmH9VtRvmZP+9t7/2flw2hxsb3XB0F/xi5yKg=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=Hyj73iUaqI2M7B9NiK3ORYpfdSis2t1K8NTtN80oAJj68If+Oxbo4g+hScOFaONzJa0Od8u+wZC0OahgQp0V8D0JkMPbjbbhSYFwPgUyKNNOnWgBSBGgR+6+tH9DFDcEUH+fICmh4yFAMC5kQrQrF+t+w7gjgaqz+YZAouuaBcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=S21tY5rN; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=3JdRgnFAFmyWl8pgpB+J2k4MqOvYT4UaKoiSnuu0LXA=; b=S21tY5rN3er41xJSdwiH8OfzRy
	Rk7tJQIyqHgyB2yyDwwOGj/edEB1ooqUmWo0LP65DzF8mx8ArPyvStghCtbRcmAWVUQKamjATRV+z
	lC9fDNcwBwdveB4RGGUA1fSy43X+zGyH3EO51JqfwHmz8GZTPeq7XngHVlTxWvwxTHRbbT7VLmwnD
	Z68HKHgbUc9l5eCQZaFC0l6+CVa1pev1rd1+6rOJGaGhcfV/RkQTsGb5B3exjqj3k9AC74Oy08uAL
	13Yr5oY5iFLhJH9UKP3GGvg819BebTAOLdZKPtLxGAKdIMfoLIsqm5TZnRAXpoDIUwXa4OfBfQ95D
	4gsrhcNg==;
Received: from sslproxy07.your-server.de ([78.47.199.104])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1smHaY-000ODB-A9; Thu, 05 Sep 2024 20:52:14 +0200
Received: from [178.197.248.15] (helo=linux.home)
	by sslproxy07.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <daniel@iogearbox.net>)
	id 1smHaW-000Fzm-1t;
	Thu, 05 Sep 2024 20:52:13 +0200
Subject: Re: [PATCH bpf-next v3 00/10] Local vmtest enhancement and RV64
 enabled
To: Pu Lehui <pulehui@huaweicloud.com>, bpf@vger.kernel.org,
 linux-riscv@lists.infradead.org, netdev@vger.kernel.org
Cc: Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman
 <eddyz87@gmail.com>, Mykola Lysenko <mykolal@fb.com>,
 =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>,
 Puranjay Mohan <puranjay@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
 Pu Lehui <pulehui@huawei.com>
References: <20240905081401.1894789-1-pulehui@huaweicloud.com>
From: Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <e9816f7c-a603-c73e-5fcc-71bbcf6c6ca3@iogearbox.net>
Date: Thu, 5 Sep 2024 20:52:12 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240905081401.1894789-1-pulehui@huaweicloud.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.10/27389/Thu Sep  5 10:33:25 2024)

On 9/5/24 10:13 AM, Pu Lehui wrote:
> Patch 1-3 fix some problem about bpf selftests. Patch 4 add local rootfs
> image support for vmtest. Patch 5 enable cross-platform testing for
> vmtest. Patch 6-10 enable vmtest on RV64.
> 
> We can now perform cross platform testing for riscv64 bpf using the
> following command:
> 
> PLATFORM=riscv64 CROSS_COMPILE=riscv64-linux-gnu- \
>    tools/testing/selftests/bpf/vmtest.sh \
>    -l <path of local rootfs image> -- \
>    ./test_progs -d \
>        \"$(cat tools/testing/selftests/bpf/DENYLIST.riscv64 \
>            | cut -d'#' -f1 \
>            | sed -e 's/^[[:space:]]*//' \
>                  -e 's/[[:space:]]*$//' \
>            | tr -s '\n' ',' \
>        )\"
> 
> For better regression, we rely on commit [0]. And since the work of riscv
> ftrace to remove stop_machine atomic replacement is in progress, we also
> need to revert commit [1] [2].
> 
> The test platform is x86_64 architecture, and the versions of relevant
> components are as follows:
>      QEMU: 8.2.0
>      CLANG: 17.0.6 (align to BPF CI)
>      ROOTFS: ubuntu noble (generated by [3])
> 
> Link: https://lore.kernel.org/all/20240831071520.1630360-1-pulehui@huaweicloud.com/ [0]
> Link: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=3308172276db [1]
> Link: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=7caa9765465f [2]
> Link: https://github.com/libbpf/ci/blob/main/rootfs/mkrootfs_debian.sh [3]

Nice work! Next step is upstream BPF CI integration? :)

Fwiw, all still works for me on x86-64 (*), so:

Acked-by: Daniel Borkmann <daniel@iogearbox.net>
Tested-by: Daniel Borkmann <daniel@iogearbox.net>

(*) fresh Equinix Ubuntu instance still requires this one for vmtest.sh, but
     that is independent of this series (and for others it seems not required)

diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index 04716a5e43f1..02dd161e5185 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -693,7 +693,7 @@ $(OUTPUT)/$(TRUNNER_BINARY): $(TRUNNER_TEST_OBJS)                   \
                              $(TRUNNER_BPFTOOL)                         \
                              | $(TRUNNER_BINARY)-extras
         $$(call msg,BINARY,,$$@)
-       $(Q)$$(CC) $$(CFLAGS) $$(filter %.a %.o,$$^) $$(LDLIBS) $$(LDFLAGS) -o $$@
+       $(Q)$$(CC) $$(CFLAGS) $(TRUNNER_LDFLAGS) $$(filter %.a %.o,$$^) $$(LDLIBS) $$(LDFLAGS) -o $$@
         $(Q)$(RESOLVE_BTFIDS) --btf $(TRUNNER_OUTPUT)/btf_data.bpf.o $$@
         $(Q)ln -sf $(if $2,..,.)/tools/build/bpftool/$(USE_BOOTSTRAP)bpftool \
                    $(OUTPUT)/$(if $2,$2/)bpftool
diff --git a/tools/testing/selftests/bpf/vmtest.sh b/tools/testing/selftests/bpf/vmtest.sh
index 79505d294c44..afbd6b785064 100755
--- a/tools/testing/selftests/bpf/vmtest.sh
+++ b/tools/testing/selftests/bpf/vmtest.sh
@@ -189,7 +189,7 @@ update_selftests()
         local selftests_dir="${kernel_checkout}/tools/testing/selftests/bpf"

         cd "${selftests_dir}"
-       ${make_command}
+       TRUNNER_LDFLAGS=-static ${make_command}

         # Mount the image and copy the selftests to the image.
         mount_image

