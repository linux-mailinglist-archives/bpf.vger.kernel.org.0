Return-Path: <bpf+bounces-50036-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D55ADA22198
	for <lists+bpf@lfdr.de>; Wed, 29 Jan 2025 17:19:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 426CA1885D99
	for <lists+bpf@lfdr.de>; Wed, 29 Jan 2025 16:19:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86C061DF984;
	Wed, 29 Jan 2025 16:19:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n/4WzsGK"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDE0228EB;
	Wed, 29 Jan 2025 16:19:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738167569; cv=none; b=K6ZXkCa6FvrRRx45ew/+4I0fv2d90yQkbZmPmXXVXjduNPECCes6nqUrmppH3b8nSV8uMR4S47oMklJsWUD3sC6gIWyj97TeWH9SFYNyLT8HGE0v29a4xIT0BgC6gkj2ybibkgnLt7sNi+gVtxWMaeCAiD1T063PzfeFyjJAtLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738167569; c=relaxed/simple;
	bh=VQ1tE7auwykWHFaAWlmFtxRv+H5gTV+mb3VLluuo+bU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lqzadzTRERZY+E6SIv5+4fNfw0TM3HQpyCZ0D5wRZh29RYk6+9gxQ91aCn25YVkydcXJRbVoZwhcCOUT4Dlu6XLQRkJaDp5ImK5cFc8o2LT9/xJklj00KwyAE4bmHYDo79ZRlrH0Qa8MZZY0EaqOL0pA5w9aR2ooiaLe3HqL7bw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n/4WzsGK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDB92C4CED1;
	Wed, 29 Jan 2025 16:19:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738167568;
	bh=VQ1tE7auwykWHFaAWlmFtxRv+H5gTV+mb3VLluuo+bU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=n/4WzsGK81F59SkkUMb+WMCMS5ZHaRbmeLw6ahJDhfCBABA4a6KVBCSwK9uQe2dCx
	 x0mNRgNXoAzA3H2ahKHYKJqAKXXN8MREVyvIrV0GgJAcoI7h6gX9LHdjLTxtClMSx4
	 EddIHSjyw6wAz2IS3Q+EeK4Ip3z4ZZbwoD7CtalDQ7OeIU8gJmPRFPLhFO6904UeOL
	 pbOtP49em5EsHn7LjmGJCQd4vKS5POHzZdHn43fsshTYlLqDnGfVcMwX7Xp0QR2BJT
	 vmSJuwnOZQMB3s3i2xEUR2Vvxazeak0N6s9PY8c7YRZAkNftTuLHW4TgGq2APSSIua
	 GqdW/Bxq24vdQ==
Date: Wed, 29 Jan 2025 17:19:22 +0100
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Jonathan Corbet <corbet@lwn.net>
Cc: Linux Doc Mailing List <linux-doc@vger.kernel.org>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org,
 bpf@vger.kernel.org, coresight@lists.linaro.org,
 linux-arm-kernel@lists.infradead.org, linux-block@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, linux-hardening@vger.kernel.org,
 linux-iio@vger.kernel.org, linux-media@vger.kernel.org,
 linux-pm@vger.kernel.org, linux-usb@vger.kernel.org,
 linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
 workflows@vger.kernel.org
Subject: Re: [RFC v2 00/38] Improve ABI documentation generation
Message-ID: <20250129171922.4322c338@foz.lan>
In-Reply-To: <87a5b96296.fsf@trenco.lwn.net>
References: <cover.1738020236.git.mchehab+huawei@kernel.org>
	<87h65i7e87.fsf@trenco.lwn.net>
	<20250129164157.3c7c072d@foz.lan>
	<87a5b96296.fsf@trenco.lwn.net>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Em Wed, 29 Jan 2025 08:58:13 -0700
Jonathan Corbet <corbet@lwn.net> escreveu:

> Mauro Carvalho Chehab <mchehab+huawei@kernel.org> writes:
> 
> > So, I'm proposing to change the minimal requirements to:
> > 	- Sphinx 3.4.3;
> > 	- Python 3.9
> >
> > By setting Sphinx minimal version to 3.4.3, we can get rid of all
> > Sphinx backward-compatible code.  
> 
> That's certainly a nice thought.
> 
> With regard to Python ... are all reasonable distributions at 3.9 at
> least?  CentOS 9 seems to be there, and Debian beyond it.  So probably
> that is a reasonable floor to set?

I didn't check, but those are the current minimal versions above 3.5 for
what we have at the Kernel tree[1]:

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

[1] Checked with:
	vermin -v $(git ls-files *.py)

    Please notice that vermin is not perfect: my script passed as version 3.6
    because the f-string check there didn't verify f-string improvements over
    time. Still, it is a quick way to check that our current minimal version
    is not aligned with reality.
 
Btw, vermin explains what is requiring more at the scripts. For instance:

	$ vermin -vv scripts/checktransupdate.py
	...
	!2, 3.9      /new_devel/v4l/docs/scripts/checktransupdate.py
	  'argparse' module requires 2.7, 3.2
	  'argparse.BooleanOptionalAction' member requires !2, 3.9
	  'datetime' module requires 2.3, 3.0
	  'datetime.datetime.strptime' member requires 2.5, 3.0
	  'logging' module requires 2.3, 3.0
	  'logging.StreamHandler' member requires 2.6, 3.0
	  'os.path.relpath' member requires 2.6, 3.0
	  f-strings require !2, 3.6

Thanks,
Mauro

