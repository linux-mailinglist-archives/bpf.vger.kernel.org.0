Return-Path: <bpf+bounces-16046-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A13F7FBA96
	for <lists+bpf@lfdr.de>; Tue, 28 Nov 2023 13:55:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BBE751C2144B
	for <lists+bpf@lfdr.de>; Tue, 28 Nov 2023 12:55:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E856751C27;
	Tue, 28 Nov 2023 12:55:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WHlgzNDL"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D30E7D60
	for <bpf@vger.kernel.org>; Tue, 28 Nov 2023 04:55:20 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id 4fb4d7f45d1cf-548f0b7ab11so7308589a12.1
        for <bpf@vger.kernel.org>; Tue, 28 Nov 2023 04:55:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701176119; x=1701780919; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=xgUdkFx7cDY3lsaw/bj6V5xWizuNuF4oVvFvbKYM/38=;
        b=WHlgzNDLmJFOUfzVmTxYJQla7qbUzLDtr7+C3JSK4i0MJEYYlGvnASZ1qvGg28uF3P
         KwENckQzIiXDUyiWsTSXaSnu3k14NNGjcO9z4ctzd9TyJj/xVmA1Ular6MJrDlUukK3E
         DgHKvsluuh5QuLFOLYpu725x6Iuhu3nhHBId2Aq2CYAwz0V1x2Hg7Sc+9u7oONX9Eojy
         YhV5Qd8jekD4L5eLiyet9xNzZRxuWXr+cxI/d4mEwzE5DywG7UwWa9adjNXe7Q5Q19OA
         z5bwxlsl8/DqzL6+XhsQyaQDffIfEie0bD01QmroqYih1bfg33/WQo5h0CPGRIT4K0Cl
         gpYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701176119; x=1701780919;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xgUdkFx7cDY3lsaw/bj6V5xWizuNuF4oVvFvbKYM/38=;
        b=sFYaSroTNykOiqs7JJDij+SkksoBsQN4r/JZmTN1RbU+pn3WHtFS/RD6G2E9FygK4i
         DkpN5aP+epYoy5bhCaIU5UdLksnlimHrw8Ojq0z9bcAcEfthJULDoQFrPEL+TtuUiT/w
         D1rZJZa2+QJ/J86KsF0ZZlY+9hCJxbG68Qq+REmDTp+P+JdH290TfLImMG4dueRerwkg
         p4HI+EnpoAxn0ZV6+hC22oxIiZOx1fK5oCvVyK87O6vKfanFYkcBi36+2xyLa6AGXvKn
         k4WDGL0UK0e7M6Ose6jZcMRG7Rqqx8L0Bgj05BgVxg1hL5hlgW2vnyFkiZQYRAYGDOzT
         1HrA==
X-Gm-Message-State: AOJu0YzqROvPmOQbDHJ8rYRCFs3MIliAVsaxry81HutJmwc3SabtVrzh
	/mVHhoTUqXJ0gBoDwef8qm3gm45yUm2F1w==
X-Google-Smtp-Source: AGHT+IGC1ZmbZW9ZRB23f4Zxbql4aMLTkKqeeviRNHPK2X7AplOJbtYC0OQyuCvVqOh17qyG38GWqQ==
X-Received: by 2002:a05:6402:c03:b0:54b:a4c8:bae7 with SMTP id co3-20020a0564020c0300b0054ba4c8bae7mr1383953edb.19.1701176119053;
        Tue, 28 Nov 2023 04:55:19 -0800 (PST)
Received: from [192.168.1.95] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id c70-20020a509fcc000000b0054b3ead7c5dsm3200447edf.76.2023.11.28.04.55.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Nov 2023 04:55:18 -0800 (PST)
Message-ID: <e7e59071c1f4009a7d15539f227ef7d92337937e.camel@gmail.com>
Subject: Re: [PATCH bpf v2 2/2] bpf: new verifier tests for stack access
From: Eduard Zingerman <eddyz87@gmail.com>
To: Andrei Matei <andreimatei1@gmail.com>
Cc: bpf@vger.kernel.org, andrii.nakryiko@gmail.com, sunhao.th@gmail.com, 
	kernel-team@dataexmachina.dev
Date: Tue, 28 Nov 2023 14:55:17 +0200
In-Reply-To: <CABWLseviz4j=KhkbX7P8soj5dkBjbg3bP08joF+y43+TFEKX0Q@mail.gmail.com>
References: <20231126015045.1092826-1-andreimatei1@gmail.com>
	 <20231126015045.1092826-3-andreimatei1@gmail.com>
	 <de2946da3720afdde07aadcda1992e3f877cca70.camel@gmail.com>
	 <CABWLseviz4j=KhkbX7P8soj5dkBjbg3bP08joF+y43+TFEKX0Q@mail.gmail.com>
Autocrypt: addr=eddyz87@gmail.com; prefer-encrypt=mutual; keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.1 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2023-11-27 at 22:15 -0500, Andrei Matei wrote:
> On Mon, Nov 27, 2023 at 8:23=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.c=
om> wrote:
> >=20
> > On Sat, 2023-11-25 at 20:50 -0500, Andrei Matei wrote:
> > > This patch adds tests for the previous patch, checking the tracking o=
f
> > > the maximum stack size and checking that accesses to uninit stack mem=
ory
> > > are allowed.
> > >=20
> > > They are a separate patch for review purposes; whoever merges them ca=
n
> > > consider squashing.
> > >=20
> > > Signed-off-by: Andrei Matei <andreimatei1@gmail.com>
> > > ---
> >=20
> > I think the strategy now is to add new tests using inline assembly,
> > e.g. as a part of verifier_* tests in test_progs.
>=20
> Thanks, I'll try that. I see in some of the verifier tests that you
> have converted to test_progs hints that they were converted
> "automatically". I'm curious what tool you've used, if any.

I wrote a small tree-sitter based tool for this:
https://github.com/eddyz87/verifier-tests-migrator

> Do you have any thoughts on how a test could assert the maximum stack
> depth? test_verifier has access to the verifier verifier log and
> parses it out of there; do you know how I could achieve the same in
> test_progs?

Could be done like in the patch below (set log level so that stack
depth is printed, match stack depth message):

diff --git a/tools/testing/selftests/bpf/progs/verifier_basic_stack.c b/too=
ls/testing/selftests/bpf/progs/verifier_basic_stack.c
index 069c3f91705c..e85ac95c8dd3 100644
--- a/tools/testing/selftests/bpf/progs/verifier_basic_stack.c
+++ b/tools/testing/selftests/bpf/progs/verifier_basic_stack.c
@@ -27,7 +27,7 @@ __naked void stack_out_of_bounds(void)
=20
 SEC("socket")
 __description("uninitialized stack1")
-__success
+__success __log_level(4) __msg("stack depth 8")
 __failure_unpriv __msg_unpriv("invalid indirect read from stack")
 __naked void uninitialized_stack1(void)
 {

> For the curiosity of someone who doesn't know  much about this code
> base - how come we moved from test_verifier, which seems a bit more
> unit-test-y, do the higher level test_progs? Is it because of the
> nicer assembly syntax?

Yes, ability to use assembly syntax is the main (sole?) driver.
In fact, tests that use annotations from bpf_misc.h and are registered
in tools/testing/selftests/bpf/prog_tests/verifier.c provide almost
the same functionality as test_verifier:
- interface:
  - select test to run using filter, e.g.:
    ./test_progs -a 'verifier_basic_stack/uninitialized stack1'
    ./test_progs -a 'verifier_basic_stack/uninitialized stack1 @unpriv'
  - see verifier log for the test, e.g.:
    ./test_progs -vvv -a 'verifier_basic_stack/uninitialized stack1'
- test expectations:
  - use __success / __failure to mark expected test outcome;
  - use __msg to search for expected messages in the log;
  - use __log_level to specify log level when program is loaded;
  - use __flags to enable additional knobs, e.g. BPF_F_TEST_STATE_FREQ;
  - use __retval if test program has to be executed;
  - use _unpriv suffix to specify any of the above for when test is
    executed in unprivileged mode.
  See comments in tools/testing/selftests/bpf/progs/bpf_misc.h for details.
- plus clang generates BTF and CO-RE relocations for us,
  with test_verifier one has to write these things "by hand"
  (which is only truly needed in tests for CO-RE/BTF).

The only drawback is compilation time, because all test_progs/*.c
files depend on all *.bpf.o files. Locally I mitigate this by using
ccache: make CC=3D'ccache clang' LLVM=3D1 -j14 test_progs .
I probably need to look at what could be done in the makefile one day.

Unfortunately neither test_verifier nor test_progs are true unit tests.

