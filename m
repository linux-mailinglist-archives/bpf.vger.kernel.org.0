Return-Path: <bpf+bounces-60204-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 80B8FAD3F31
	for <lists+bpf@lfdr.de>; Tue, 10 Jun 2025 18:39:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 35F75168487
	for <lists+bpf@lfdr.de>; Tue, 10 Jun 2025 16:39:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D047242905;
	Tue, 10 Jun 2025 16:39:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="OCab6z7h"
X-Original-To: bpf@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AA4D20EB;
	Tue, 10 Jun 2025 16:39:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749573575; cv=none; b=QOL130IMqbahA9Svpe3si9jJ/KxVgfqZNC1aeasorO+o4YVu/WjZM1TM2iGfT6MNNWGcG6AzYL+q73gU2FjZlSN2G60ZQN2/8bmRNtH+Drmx5U+5Ur1lDAtL0BX4Txwn9qDcO0+yRtan9xEWoC4XAj4az9puJ0hYwgtIwtW+Hb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749573575; c=relaxed/simple;
	bh=IzbaMB9OvXXQvX/1E8JH+mMCYHDXzFNFdohAOhkI6pM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=H7D6bXDPFH47/enE3AvWuafG0VvWShwrRiaGyO58grjjpyo3irED+DRKRoU3U4/1PgXM3NulhsrYLiHr+5gEROMdwrzLTIqOvTOkr1tsca3ooQxMhfzsjfOIbcMbaCM8rSSXAI/anlRTw7gtPJwvuYq6CW1qugle3Xie9+dQeoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=OCab6z7h; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from narnia (unknown [40.78.13.147])
	by linux.microsoft.com (Postfix) with ESMTPSA id 086042114D87;
	Tue, 10 Jun 2025 09:39:32 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 086042114D87
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1749573574;
	bh=yx3CvqerorMDTClRiMNhud56+B+k5vow3fMsAkUnrHU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=OCab6z7hG/k9mCuBybtz0151IRJIwz5Xijd/R9kAUvzFQys7wilLnCz43djRHteCb
	 wehvZwhL/7V36ph+5PVp11ZXP2Y1rMXHzsgP6FksYQEUmd+6HvQ3O1+f6DwRP2krXE
	 WxbkYIJqD/KNC+bq2NrIfzhSZVl2Ha3ERJNkd+UM=
From: Blaise Boscaccy <bboscaccy@linux.microsoft.com>
To: KP Singh <kpsingh@kernel.org>, bpf@vger.kernel.org,
 linux-security-module@vger.kernel.org
Cc: paul@paul-moore.com, kys@microsoft.com, ast@kernel.org,
 daniel@iogearbox.net, andrii@kernel.org, KP Singh <kpsingh@kernel.org>
Subject: Re: [PATCH 12/12] selftests/bpf: Enable signature verification for
 all lskel tests
In-Reply-To: <20250606232914.317094-13-kpsingh@kernel.org>
References: <20250606232914.317094-1-kpsingh@kernel.org>
 <20250606232914.317094-13-kpsingh@kernel.org>
Date: Tue, 10 Jun 2025 09:39:31 -0700
Message-ID: <87tt4nlfek.fsf@microsoft.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

KP Singh <kpsingh@kernel.org> writes:

> Convert the kernel's generated verification certificate into a C header
> file using xxd.  Finally, update the main test runner to load this
> certificate into the session keyring via the add_key() syscall before
> executing any tests.
>
> The kernel's module signing verification certificate is converted to a
> headerfile and loaded as a session key and all light skeleton tests are
> updated to be signed.
>
> Signed-off-by: KP Singh <kpsingh@kernel.org>
> ---
>  tools/testing/selftests/bpf/.gitignore   |  1 +
>  tools/testing/selftests/bpf/Makefile     | 13 +++++++++++--
>  tools/testing/selftests/bpf/test_progs.c | 13 +++++++++++++
>  3 files changed, 25 insertions(+), 2 deletions(-)
>
> diff --git a/tools/testing/selftests/bpf/.gitignore b/tools/testing/selftests/bpf/.gitignore
> index e2a2c46c008b..5ab96f8ab1c9 100644
> --- a/tools/testing/selftests/bpf/.gitignore
> +++ b/tools/testing/selftests/bpf/.gitignore
> @@ -45,3 +45,4 @@ xdp_redirect_multi
>  xdp_synproxy
>  xdp_hw_metadata
>  xdp_features
> +verification_cert.h
> diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
> index cf5ed3bee573..778b54be7ef4 100644
> --- a/tools/testing/selftests/bpf/Makefile
> +++ b/tools/testing/selftests/bpf/Makefile
> @@ -7,6 +7,7 @@ CXX ?= $(CROSS_COMPILE)g++
>  
>  CURDIR := $(abspath .)
>  TOOLSDIR := $(abspath ../../..)
> +CERTSDIR := $(abspath ../../../../certs)
>  LIBDIR := $(TOOLSDIR)/lib
>  BPFDIR := $(LIBDIR)/bpf
>  TOOLSINCDIR := $(TOOLSDIR)/include
> @@ -534,7 +535,7 @@ HEADERS_FOR_BPF_OBJS := $(wildcard $(BPFDIR)/*.bpf.h)		\
>  # $1 - test runner base binary name (e.g., test_progs)
>  # $2 - test runner extra "flavor" (e.g., no_alu32, cpuv4, bpf_gcc, etc)
>  define DEFINE_TEST_RUNNER
> -
> +LSKEL_SIGN := -S -k $(CERTSDIR)/signing_key.pem -i $(CERTSDIR)/signing_key.x509
>  TRUNNER_OUTPUT := $(OUTPUT)$(if $2,/)$2
>  TRUNNER_BINARY := $1$(if $2,-)$2
>  TRUNNER_TEST_OBJS := $$(patsubst %.c,$$(TRUNNER_OUTPUT)/%.test.o,	\
> @@ -601,7 +602,7 @@ $(TRUNNER_BPF_LSKELS): %.lskel.h: %.bpf.o $(BPFTOOL) | $(TRUNNER_OUTPUT)
>  	$(Q)$$(BPFTOOL) gen object $$(<:.o=.llinked2.o) $$(<:.o=.llinked1.o)
>  	$(Q)$$(BPFTOOL) gen object $$(<:.o=.llinked3.o) $$(<:.o=.llinked2.o)
>  	$(Q)diff $$(<:.o=.llinked2.o) $$(<:.o=.llinked3.o)
> -	$(Q)$$(BPFTOOL) gen skeleton -L $$(<:.o=.llinked3.o) name $$(notdir $$(<:.bpf.o=_lskel)) > $$@
> +	$(Q)$$(BPFTOOL) gen skeleton $(LSKEL_SIGN) $$(<:.o=.llinked3.o) name $$(notdir $$(<:.bpf.o=_lskel)) > $$@
>  	$(Q)rm -f $$(<:.o=.llinked1.o) $$(<:.o=.llinked2.o) $$(<:.o=.llinked3.o)
>  
>  $(LINKED_BPF_OBJS): %: $(TRUNNER_OUTPUT)/%
> @@ -697,6 +698,13 @@ $(OUTPUT)/$(TRUNNER_BINARY): $(TRUNNER_TEST_OBJS)			\
>  
>  endef
>  
> +CERT_HEADER := verification_cert.h
> +CERT_SOURCE := $(CERTSDIR)/signing_key.x509
> +
> +$(CERT_HEADER): $(CERT_SOURCE)
> +	@echo "GEN-CERT-HEADER: $(CERT_HEADER) from $<"
> +	$(Q)xxd -i -n test_progs_verification_cert $< > $@
> +
>  # Define test_progs test runner.
>  TRUNNER_TESTS_DIR := prog_tests
>  TRUNNER_BPF_PROGS_DIR := progs
> @@ -716,6 +724,7 @@ TRUNNER_EXTRA_SOURCES := test_progs.c		\
>  			 disasm.c		\
>  			 disasm_helpers.c	\
>  			 json_writer.c 		\
> +			 $(CERT_HEADER)		\
>  			 flow_dissector_load.h	\
>  			 ip_check_defrag_frags.h
>  TRUNNER_EXTRA_FILES := $(OUTPUT)/urandom_read				\
> diff --git a/tools/testing/selftests/bpf/test_progs.c b/tools/testing/selftests/bpf/test_progs.c
> index 309d9d4a8ace..02a85dda30e6 100644
> --- a/tools/testing/selftests/bpf/test_progs.c
> +++ b/tools/testing/selftests/bpf/test_progs.c
> @@ -14,12 +14,14 @@
>  #include <netinet/in.h>
>  #include <sys/select.h>
>  #include <sys/socket.h>
> +#include <linux/keyctl.h>
>  #include <sys/un.h>
>  #include <bpf/btf.h>
>  #include <time.h>
>  #include "json_writer.h"
>  
>  #include "network_helpers.h"
> +#include "verification_cert.h"
>  
>  /* backtrace() and backtrace_symbols_fd() are glibc specific,
>   * use header file when glibc is available and provide stub
> @@ -1928,6 +1930,13 @@ static void free_test_states(void)
>  	}
>  }
>  
> +static __u32 register_session_key(const char *key_data, size_t key_data_size)
> +{
> +	return syscall(__NR_add_key, "asymmetric", "libbpf_session_key",
> +			(const void *)key_data, key_data_size,
> +			KEY_SPEC_SESSION_KEYRING);
> +}
> +
>  int main(int argc, char **argv)
>  {
>  	static const struct argp argp = {
> @@ -1961,6 +1970,10 @@ int main(int argc, char **argv)
>  	/* Use libbpf 1.0 API mode */
>  	libbpf_set_strict_mode(LIBBPF_STRICT_ALL);
>  	libbpf_set_print(libbpf_print_fn);
> +	err = register_session_key((const char *)test_progs_verification_cert,
> +				   test_progs_verification_cert_len);
> +	if (err < 0)
> +		return err;
>  
>  	traffic_monitor_set_print(traffic_monitor_print_fn);
>  
> -- 
> 2.43.0


There aren't any test cases showing the "trusted" loader doing any sort
of enforcement of blocking invalid programs or maps.

-blaise

