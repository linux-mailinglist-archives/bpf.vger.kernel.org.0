Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9881760D71A
	for <lists+bpf@lfdr.de>; Wed, 26 Oct 2022 00:28:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232619AbiJYW2w (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 25 Oct 2022 18:28:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232447AbiJYW2t (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 25 Oct 2022 18:28:49 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 779597D785
        for <bpf@vger.kernel.org>; Tue, 25 Oct 2022 15:28:47 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id fy4so16540763ejc.5
        for <bpf@vger.kernel.org>; Tue, 25 Oct 2022 15:28:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y888JDclK3ghVot9Xo2XQze7CjHGsTQvc0cMj3gqRXc=;
        b=HlTMsqxGKpzRv97N22t03nlacgceAaER0elc3LVgLR5FxAdLLlJu+liAXYfE7JX3do
         jk9wXyYbTf0uOR3faxlpw3jKt+bF7cGHqWGBulSA3J6VeMi0led/sMvmibVcj26Z38hB
         sqFVshVIRED6KryKy+HknDnQiFqVMs2gkvaUY2oCz99QYEX7ApqoDhBwx1iAndW5aNZT
         67HRVIPbZJxKJmwz1lXjjQIUkVwoQcS8OE3n67uLV7zDBXbO7kvJ/BQ9O3AQmJTDVG8N
         GTgAMF5eEj3Ru2glatZOXyOeCPwiMGEQ/ganbBHCNMmVRJ6GSc/cPRd4QUth95bIOsmf
         MVzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y888JDclK3ghVot9Xo2XQze7CjHGsTQvc0cMj3gqRXc=;
        b=PIbxft2mPjhwJ6yHaxGl/Bl+zYXEbs79ayV3XGFrD5HLf7eytZ2TjAI6vHWVwUoOoZ
         MZlJY1ZisJN7CS2kI1vDRa5GMNKsG3KdS2lhceRPuxEETafkpDH0Ojc01RiaQ0KwQOJW
         zr88gZyGgQqJYC7dRxo8G9TZPdOibuWCmXohGptNSWJzcecTtlLim1x4sHbLDn88+s6w
         zYxhGNdGlZ44+BLPndat8BnN5EnvoHBd/YGcdH8VTVUFql1Fvn1BRwqsA394qgnE8U5Y
         aqB+qUbUC6u8Qge3CoZFDVwINJMMhX7Lca9EUECuZOMOWOBCZ0GoTGLTMtxCi2m/uJgL
         Y05g==
X-Gm-Message-State: ACrzQf2YHF0JNf8cu9j73xHB1CEmjxZA5IMUVP7UllBmgEM1NvVUfBq+
        LVTUPTjDqedfSc/d3r6aiGl7sdQJJbrM92hm
X-Google-Smtp-Source: AMsMyM5PcyZFfZEAYeeHWK1NEQ0p5PddV04O42vqQ1zo6EB1bCZX4YeKqRyt/pp4neFCwoQtQURRNQ==
X-Received: by 2002:a17:907:72c5:b0:798:1c8f:5bc7 with SMTP id du5-20020a17090772c500b007981c8f5bc7mr26591770ejc.119.1666736926853;
        Tue, 25 Oct 2022 15:28:46 -0700 (PDT)
Received: from pluto.. (boundsly.muster.volia.net. [93.72.16.93])
        by smtp.gmail.com with ESMTPSA id ks23-20020a170906f85700b0078d175d6dc5sm1993119ejb.201.2022.10.25.15.28.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Oct 2022 15:28:46 -0700 (PDT)
From:   Eduard Zingerman <eddyz87@gmail.com>
To:     bpf@vger.kernel.org, ast@kernel.org
Cc:     andrii@kernel.org, daniel@iogearbox.net, kernel-team@fb.com,
        yhs@fb.com, arnaldo.melo@gmail.com,
        Eduard Zingerman <eddyz87@gmail.com>
Subject: [RFC bpf-next 08/12] kbuild: Script to infer header guard values for uapi headers
Date:   Wed, 26 Oct 2022 01:27:57 +0300
Message-Id: <20221025222802.2295103-9-eddyz87@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221025222802.2295103-1-eddyz87@gmail.com>
References: <20221025222802.2295103-1-eddyz87@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

The script infers header guard defines in headers from
include/uapi/**/*.h . E.g. header guard for the
`include/uapi/linux/tcp.h` is `_UAPI_LINUX_TCP_H`:

    include/uapi/linux/tcp.h:

      #ifndef _UAPI_LINUX_TCP_H
      #define _UAPI_LINUX_TCP_H
      ...
      union tcp_word_hdr {
            struct tcphdr hdr;
            __be32        words[5];
      };
      ...
      #endif /* _UAPI_LINUX_TCP_H */

The output of the script could be used as an input to pahole's
`--header_guards_db` parameter. This information is necessary to
repeat the same header guards in the `vmlinux.h` generated from BTF.

It is not possible to infer the guard names from header file names
alone, the file content has to be analyzed. The following heuristic is
used to infer guard for a specific file:
- All pairs `#ifndef <candidate>` / `#define <candidate>` are collected;
- If a unique candidate matching regex `${headername}.*_H(EADER)?` it
  is selected;
- If a unique candidate matching regex `_H(EADER)?_` it is selected;
- If a unique candidate matching regex `_H(EADER)?$` it is selected;

There is also a small list of headers that can't be caught by the
rules above, 15 in total. These headers and corresponding guard values
are listed in the `%OVERRIDES` hash table.

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 scripts/infer_header_guards.pl | 191 +++++++++++++++++++++++++++++++++
 1 file changed, 191 insertions(+)
 create mode 100755 scripts/infer_header_guards.pl

diff --git a/scripts/infer_header_guards.pl b/scripts/infer_header_guards.pl
new file mode 100755
index 000000000000..201008ac83f3
--- /dev/null
+++ b/scripts/infer_header_guards.pl
@@ -0,0 +1,191 @@
+#!/usr/bin/env perl
+# SPDX-License-Identifier: GPL-2.0
+
+# This script scans the passed directory for header files (files ending with ".h").
+# For each header file it tries to infer the name of a C pre-processor
+# variable used as a double include guard (dubbed as "header guard").
+# For example:
+#
+#   #ifdef __MY_HEADER__  // <-- "header guard"
+#     ...
+#   #endif
+#
+# The inferred guards are printed to stdout in the following format:
+#
+#   <header-file> <header-guard>
+#
+# This is an expected format for pahole --header_guards_db parameter.
+# Intended usage is to infer header guards for Linux UAPI headers.
+# The collected information is further used in BTF embedded into kernel.
+#
+# The following inference logic is used for each file:
+# - find all pairs `#ifndef <name> #define <name>`
+# - if there is a unique <name> that matches a pattern - use this
+#   <name> as a header guard, (see subroutine `select_guard` for the
+#   list of the patterns);
+# - files containing only #include directives are safe to ignore.
+#
+# There are a few UAPI header files that don't fit in such logic,
+# header guards for these files are hard-coded in %OVERRIDES hash.
+#
+# The script reports inference only when --report-failures flag is
+# passed. This flag is intended for BPF tests.
+#
+# See subroutine `help` for usage info.
+
+use strict;
+use warnings;
+use File::Basename;
+use File::Find;
+use Getopt::Long;
+
+sub help {
+	my $message = << "EOM";
+Usage:
+  $0 [--report-failures] directory-or-file...
+  $0 --help
+
+For a specific file or for each .h file in a directory infer the name
+of a C pre-processor variable used as a double include guard.
+
+Options:
+  --report-failures   Report inference errors to stderr,
+                      exit with non-zero code if guards were not inferred
+                      for some files.
+  --help              Print this message and exit.
+EOM
+	print $message;
+}
+
+my %OVERRIDES = (
+	# Header guards that don't follow common naming rules
+	"include/uapi/linux/cciss_ioctl.h" => "_UAPICCISS_IOCTLH",
+	"include/uapi/linux/hpet.h" => "_UAPI__HPET__",
+	"include/uapi/linux/if_ppp.h" => "_PPP_IOCTL_H",
+	"include/uapi/linux/netfilter/xt_NFLOG.h" => "_XT_NFLOG_TARGET",
+	"include/uapi/linux/netfilter_ipv6/ip6t_NPT.h" => "__NETFILTER_IP6T_NPT",
+	"include/uapi/linux/quota.h" => "_UAPI_LINUX_QUOTA_",
+	"include/uapi/linux/v4l2-common.h" => "__V4L2_COMMON__",
+	# Headers that should be ignored
+	"arch/x86/include/uapi/asm/hw_breakpoint.h" => undef,
+	"arch/x86/include/uapi/asm/posix_types.h" => undef,
+	"arch/x86/include/uapi/asm/setup.h" => undef,
+	"include/generated/uapi/linux/version.h" => undef,
+	"include/uapi/asm-generic/bitsperlong.h" => undef,
+	"include/uapi/asm-generic/kvm_para.h" => undef,
+	"include/uapi/asm-generic/unistd.h" => undef,
+	"include/uapi/linux/irqnr.h" => undef,
+	"include/uapi/linux/zorro_ids.h" => undef,
+	);
+
+sub get_basename {
+	my ($filename) = @_;
+	my $basename = fileparse($filename, qr/\.[^.]*/);
+	return $basename;
+}
+
+sub find_bracket_candidates {
+	my ($filename) = @_;
+	my @candidates = ();
+	my $guard_candidate = undef;
+	my $safe_to_ignore = 1;
+
+	open my $file, $filename or die "Can't open file $filename: $!";
+	while (my $line = <$file>) {
+		if (not($line =~ "^#include")) {
+			$safe_to_ignore = 0;
+		}
+		if ($line =~ "^#ifndef[ \t]+([a-zA-Z0-9_]+)") {
+			$guard_candidate = $1;
+		} elsif ($guard_candidate && $line =~ "^#define[ \t]+${guard_candidate}") {
+			push(@candidates, $guard_candidate);
+			$guard_candidate = undef;
+		}
+	}
+	close $file;
+
+	return ($safe_to_ignore, @candidates);
+}
+
+sub select_guard {
+	my ($filename, @candidates) = @_;
+	my $basename = get_basename($filename);
+	my @regexes = ("$basename.*_H(EADER)?",
+		       "_H(EADER)?_",
+		       "_H(EADER)?\$");
+	foreach my $re (@regexes) {
+		my @filtered = grep(/$re/i, @candidates);
+		if (scalar(@filtered) == 1) {
+			return $filtered[0];
+		}
+	}
+
+	return undef;
+}
+
+sub collect_headers {
+	my ($dir) = @_;
+	my @headers = ();
+
+	find(sub { /\.h$/ && push(@headers, $File::Find::name); }, $dir);
+
+	return @headers;
+}
+
+my $report_failures = 0;
+my $options_parsed = GetOptions(
+	"report-failures" => \$report_failures,
+	"help" => sub { help(); exit 0; },
+    );
+
+if (!$options_parsed || scalar @ARGV == 0) {
+	help();
+	exit 1;
+}
+
+my @headers;
+
+foreach my $dir_or_file (@ARGV) {
+	if (-f $dir_or_file) {
+		push(@headers, $dir_or_file);
+	} elsif (-d $dir_or_file) {
+		push(@headers, collect_headers($dir_or_file));
+	} else {
+		print("'$dir_or_file' is not a file or directory.\n");
+		help();
+		exit 1;
+	}
+}
+
+my $rc = 0;
+
+foreach my $header (@headers) {
+	my $basename = get_basename($header);
+	my $guard;
+
+	if (exists $OVERRIDES{$header}) {
+		$guard = $OVERRIDES{$basename};
+	} else {
+		my ($safe_to_ignore, @candidates) = find_bracket_candidates($header);
+		$guard = select_guard($header, @candidates);
+		if ((not $guard) && (not $safe_to_ignore) && $report_failures) {
+			print STDERR "Can't select guard for $header, candidates:\n";
+			print STDERR "  ";
+			if (scalar(@candidates)) {
+				print STDERR join(", ", @candidates);
+			} else {
+				print STDERR "<no candidates>"
+			}
+			print STDERR "\n";
+			$rc = 1;
+		}
+	}
+	if ($guard) {
+		# Remove the _UAPI prefix/suffix the same way
+		# scripts/headers_install.sh does it.
+		$guard =~ s/_UAPI//;
+		print("$header $guard\n");
+	}
+}
+
+exit $rc;
-- 
2.34.1

