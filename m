Return-Path: <bpf+bounces-51107-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B8B5EA30359
	for <lists+bpf@lfdr.de>; Tue, 11 Feb 2025 07:20:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 57E83166EBD
	for <lists+bpf@lfdr.de>; Tue, 11 Feb 2025 06:20:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B2FB1E9B32;
	Tue, 11 Feb 2025 06:19:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DdQPTYrR"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B445B1E9B00;
	Tue, 11 Feb 2025 06:19:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739254777; cv=none; b=SIfMmRWgZmd7kAdEsXzeqynrpIhtYoyNszPG0+wfr/srfZr9UV29UDbMJdt2jJb8ovIVIcy21oscFz4p/+qqzuBy9iAwMVpPpUVo5OncRLeWCEvhip7RCACQOj2cHFGs0T52iKxo90GfayBuf4vzbzv0N3HSO0zG7YV7ZrJRLVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739254777; c=relaxed/simple;
	bh=T9NTAO1QRuFZX33xgmpknoyP3QWfqh1E9HVIBAeBXR8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KdlqcFxYMR+anBihJ7j3gfQ7Kw4KR9ieAGe27SSTNEJO0KezK788ytRU24VN9tngCX1w2Q1iBdbEnSl5ClLoLlEky20q4Der9Ni45nMSTmGrFQi5u0E/anO2OImE2SrBoYv+b9+ffNP5iZGwQk7VCGoR1NxKaKFDkim+v6wPWNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DdQPTYrR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38726C4CEE7;
	Tue, 11 Feb 2025 06:19:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739254777;
	bh=T9NTAO1QRuFZX33xgmpknoyP3QWfqh1E9HVIBAeBXR8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DdQPTYrR84kN7ksxe3PxP9pR7cF8RAgLe5OLQOpiTJvai6jcgfWeRV+F9Dp9+SA6Z
	 eZGhM8I+57bK8+vhqXPCHL7du6TTaj8FGiCnM27eoNjorsHLgp2jtVUnddpdmOZ9a9
	 JdKPUIq4ZER7OFQi4wQzAFrtBcqDXiphzzl+5vuhJkkfSiOuDWSqN5cObJdMBs8EMk
	 Dxqeb7+Imtacz6y2/gIYgT9Q9CkTtvgqUfzNKAsxlVoI3J1TB8DqKw/u5Qr6fZyMnl
	 XYRPXXgtSSWXxt9f5EaDW2Dz3NpVbGBk3HCo1TX+c4s6YCmMwNh33D+l1vf4FIGt/r
	 Q/G++N2+YAyeQ==
Received: from mchehab by mail.kernel.org with local (Exim 4.98)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1thjcN-00000008Y6a-1D6m;
	Tue, 11 Feb 2025 07:19:35 +0100
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Jonathan Corbet <corbet@lwn.net>,
	Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	"Mauro Carvalho Chehab" <mchehab+huawei@kernel.org>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Nathan Chancellor <mchehab+huawei@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev,
	workflows@vger.kernel.org
Subject: [PATCH 2/4] docs: changes: update Python minimal version
Date: Tue, 11 Feb 2025 07:19:02 +0100
Message-ID: <34dda7a5a75f30380d95d8e85a8813be98dc72fe.1739254187.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1739254187.git.mchehab+huawei@kernel.org>
References: <cover.1739254187.git.mchehab+huawei@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

The current minimal version doesn't match what we have currently
at the Kernel:

	$ vermin -v  $(git ls-files *.py)
	...
	Minimum required versions: 3.10
	Incompatible versions:     2

Those are the Python scripts requiring versions higher than current minimal (3.5):

        !2, 3.10     tools/net/sunrpc/xdrgen/generators/__init__.py
        !2, 3.10     tools/net/sunrpc/xdrgen/generators/program.py
        !2, 3.10     tools/net/sunrpc/xdrgen/subcmds/source.py
        !2, 3.10     tools/net/sunrpc/xdrgen/xdr_ast.py
        !2, 3.10     tools/power/cpupower/bindings/python/test_raw_pylibcpupower.py
        !2, 3.9      tools/testing/selftests/net/rds/test.py
        !2, 3.9      tools/net/ynl/ethtool.py
        !2, 3.9      tools/net/ynl/cli.py
        !2, 3.9      scripts/checktransupdate.py
        !2, 3.8      tools/testing/selftests/tc-testing/plugin-lib/nsPlugin.py
        !2, 3.8      tools/testing/selftests/hid/tests/base.py
        !2, 3.7      tools/testing/selftests/turbostat/smi_aperf_mperf.py
        !2, 3.7      tools/testing/selftests/turbostat/defcolumns.py
        !2, 3.7      tools/testing/selftests/turbostat/added_perf_counters.py
        !2, 3.7      tools/testing/selftests/hid/tests/conftest.py
        !2, 3.7      tools/testing/kunit/qemu_config.py
        !2, 3.7      tools/testing/kunit/kunit_tool_test.py
        !2, 3.7      tools/testing/kunit/kunit.py
        !2, 3.7      tools/testing/kunit/kunit_parser.py
        !2, 3.7      tools/testing/kunit/kunit_kernel.py
        !2, 3.7      tools/testing/kunit/kunit_json.py
        !2, 3.7      tools/testing/kunit/kunit_config.py
        !2, 3.7      tools/perf/scripts/python/gecko.py
        !2, 3.7      scripts/rust_is_available_test.py
        !2, 3.7      scripts/bpf_doc.py
        !2, 3.6      tools/writeback/wb_monitor.py
        !2, 3.6      tools/workqueue/wq_monitor.py
        !2, 3.6      tools/workqueue/wq_dump.py
        !2, 3.6      tools/usb/p9_fwd.py
        !2, 3.6      tools/tracing/rtla/sample/timerlat_load.py
        !2, 3.6      tools/testing/selftests/net/openvswitch/ovs-dpctl.py
        !2, 3.6      tools/testing/selftests/net/nl_netdev.py
        !2, 3.6      tools/testing/selftests/net/lib/py/ynl.py
        !2, 3.6      tools/testing/selftests/net/lib/py/utils.py
        !2, 3.6      tools/testing/selftests/net/lib/py/nsim.py
        !2, 3.6      tools/testing/selftests/net/lib/py/netns.py
        !2, 3.6      tools/testing/selftests/net/lib/py/ksft.py
        !2, 3.6      tools/testing/selftests/kselftest/ksft.py
        !2, 3.6      tools/testing/selftests/hid/tests/test_tablet.py
        !2, 3.6      tools/testing/selftests/hid/tests/test_sony.py
        !2, 3.6      tools/testing/selftests/hid/tests/test_multitouch.py
        !2, 3.6      tools/testing/selftests/hid/tests/test_mouse.py
        !2, 3.6      tools/testing/selftests/hid/tests/base_gamepad.py
        !2, 3.6      tools/testing/selftests/hid/tests/base_device.py
        !2, 3.6      tools/testing/selftests/drivers/net/stats.py
        !2, 3.6      tools/testing/selftests/drivers/net/shaper.py
        !2, 3.6      tools/testing/selftests/drivers/net/queues.py
        !2, 3.6      tools/testing/selftests/drivers/net/ping.py
        !2, 3.6      tools/testing/selftests/drivers/net/lib/py/remote_ssh.py
        !2, 3.6      tools/testing/selftests/drivers/net/lib/py/load.py
        !2, 3.6      tools/testing/selftests/drivers/net/lib/py/__init__.py
        !2, 3.6      tools/testing/selftests/drivers/net/lib/py/env.py
        !2, 3.6      tools/testing/selftests/drivers/net/hw/rss_ctx.py
        !2, 3.6      tools/testing/selftests/drivers/net/hw/pp_alloc_fail.py
        !2, 3.6      tools/testing/selftests/drivers/net/hw/nic_performance.py
        !2, 3.6      tools/testing/selftests/drivers/net/hw/nic_link_layer.py
        !2, 3.6      tools/testing/selftests/drivers/net/hw/lib/py/linkconfig.py
        !2, 3.6      tools/testing/selftests/drivers/net/hw/lib/py/__init__.py
        !2, 3.6      tools/testing/selftests/drivers/net/hw/devmem.py
        !2, 3.6      tools/testing/selftests/drivers/net/hw/devlink_port_split.py
        !2, 3.6      tools/testing/selftests/drivers/net/hw/csum.py
        !2, 3.6      tools/testing/selftests/devices/probe/test_discoverable_devices.py
        !2, 3.6      tools/testing/selftests/bpf/test_bpftool_synctypes.py
        !2, 3.6      tools/testing/selftests/bpf/generate_udp_fragments.py
        !2, 3.6      tools/testing/kunit/run_checks.py
        !2, 3.6      tools/testing/kunit/kunit_printer.py
        !2, 3.6      tools/sched_ext/scx_show_state.py
        !2, 3.6      tools/perf/tests/shell/lib/perf_metric_validation.py
        !2, 3.6      tools/perf/tests/shell/lib/perf_json_output_lint.py
        !2, 3.6      tools/perf/scripts/python/parallel-perf.py
        !2, 3.6      tools/perf/scripts/python/flamegraph.py
        !2, 3.6      tools/perf/scripts/python/arm-cs-trace-disasm.py
        !2, 3.6      tools/perf/pmu-events/models.py
        !2, 3.6      tools/perf/pmu-events/metric_test.py
        !2, 3.6      tools/perf/pmu-events/metric.py
        !2, 3.6      tools/perf/pmu-events/jevents.py
        !2, 3.6      tools/net/ynl/ynl-gen-rst.py
        !2, 3.6      tools/net/ynl/ynl-gen-c.py
        !2, 3.6      tools/net/ynl/lib/ynl.py
        !2, 3.6      tools/net/ynl/lib/nlspec.py
        !2, 3.6      tools/crypto/tcrypt/tcrypt_speed_compare.py
        !2, 3.6      tools/cgroup/iocost_monitor.py
        !2, 3.6      tools/cgroup/iocost_coef_gen.py
        !2, 3.6      scripts/make_fit.py
        !2, 3.6      scripts/macro_checker.py
        !2, 3.6      scripts/get_abi.py
        !2, 3.6      scripts/generate_rust_analyzer.py
        !2, 3.6      scripts/gdb/linux/timerlist.py
        !2, 3.6      scripts/gdb/linux/pgtable.py
        !2, 3.6      scripts/clang-tools/run-clang-tools.py
        !2, 3.6      Documentation/sphinx/automarkup.py

Even if we exclude tools/net/sunrpc/xdrgen/, the minimal version is
Python 3.9.

Update process/changes to reflect the current minimal version required to
run Python scripts outside tools.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 Documentation/process/changes.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/process/changes.rst b/Documentation/process/changes.rst
index 66015c768cfc..d564362773b5 100644
--- a/Documentation/process/changes.rst
+++ b/Documentation/process/changes.rst
@@ -62,7 +62,7 @@ Sphinx\ [#f1]_         3.4.3            sphinx-build --version
 GNU tar                1.28             tar --version
 gtags (optional)       6.6.5            gtags --version
 mkimage (optional)     2017.01          mkimage --version
-Python (optional)      3.5.x            python3 --version
+Python (optional)      3.9.x            python3 --version
 GNU AWK (optional)     5.1.0            gawk --version
 ====================== ===============  ========================================
 
-- 
2.48.1


