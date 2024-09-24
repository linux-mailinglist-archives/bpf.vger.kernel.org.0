Return-Path: <bpf+bounces-40232-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D9AC4983C75
	for <lists+bpf@lfdr.de>; Tue, 24 Sep 2024 07:45:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 078E71C20E1E
	for <lists+bpf@lfdr.de>; Tue, 24 Sep 2024 05:45:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AC1946447;
	Tue, 24 Sep 2024 05:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="By8UIm3f"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A64153370
	for <bpf@vger.kernel.org>; Tue, 24 Sep 2024 05:45:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727156704; cv=none; b=oBLaRZ+IZj9QPJ17g/MbOX3FbrdLkr7cTS+TC8aaa06gFeQn5PLbsZWQbBr+U50RAYnmchJLZE55uaUhMDTjYwnSI/MF3TetMFejJoD740i4LeBet5WQEUkpl5a/zSJtH6chDDCJyxRIGBbSzf83hxXBYqXqxb6zJapaXaLWhUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727156704; c=relaxed/simple;
	bh=uMiymlOxCFUiBez0XfIawguvEyaqha8nPq5nCe7yypE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=j+In5MUMvP3mWkda4TRQXwHJRGj2j2FU0LUT/LSxXdKnM/JElhqw3k8/w2QX8FF/SWknv7I0Mf9UcJijI1cFsyqyG42W1gRgp8/OX9rM7bJXvG64EfzZ2I/HEaK+DeFZ4SkV4DqGNmdTPURjDADrXhkbtWR2DSDES/O0qnXdm94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=By8UIm3f; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-7db0fb03df5so3502670a12.3
        for <bpf@vger.kernel.org>; Mon, 23 Sep 2024 22:45:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727156702; x=1727761502; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H184UGHrLkc0HyKrRJyiA/dtOYcWmyZXKOJNScTOrfw=;
        b=By8UIm3fdihyRkPvOigS1QzQitmNtXwiQ8sR1nC+QW+7sk1N+lkz/Mza9DS3ydPXWI
         HNo0DuXfiBAKlgEsZqod/7LdQDa1K3NGNcZdF3vdSEp6jtLCqXt98e5c6TzOk1PF63zi
         mFwd26t4zl/L1qgCvTl6M+fCc2jH+9cCFeMdRWnSespY4ueN+kgzKzt5KVtWGbKhH1UX
         pnpGVw+NYOBvhrbO2HZUM3h2re0n+iT8x3qTQ2YV+RMe02IWPzUA7/WykXv+jnuvukec
         yp/ljP26YfcvuhkYBq5YrdnJ0qkbATHXSSJilPnW9aW+QgtUER73nXDHfNOJcAXqCVIb
         iAtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727156702; x=1727761502;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H184UGHrLkc0HyKrRJyiA/dtOYcWmyZXKOJNScTOrfw=;
        b=tmCaxQb6gY91rbbQSsbt3FAdM5f/J/q+XA2yY1NevdGYa8ChueouOs8F/J2ri5QQr5
         iStC24lm+H8hvX/dIbKCDXd4BctFAgCtF7nog7iAeB2HPRibcSfVSO+RacMGgJL4vzZU
         iO3CPl8j0H/dwcoJCn3vSc1dD6SZv7E+ywElJH9Rl8ab5B070WkqemROVWlDBNbYZ4WS
         cZAsslVA+Wn84Y6ydo1A2jY3c1M79Ns2plv3IKer1m4FjjaY/qCsmYq8jQMNF0HsNC5t
         sZB3DG130Je3EtpJJVfL9inDcD8RMmMqhzQI2yOspKqk0DkG3IB628xW9Z+h23qTG207
         f/1Q==
X-Forwarded-Encrypted: i=1; AJvYcCWMiZelhaB2VSJ04wENh4ikbjIhL8MqTCPkYkLAmlWLm1227G8tRNkXU6bE31PgUaTRioE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQ2EScnlCmGCazWPE4rfXCRZkfKJEyzcb3OezfySke/BmMN7GR
	3usrLTobxS12eBgVUH25Ws5LzxbY8ZW2CKo1EMCfCabRPlxg4ShAU5w0IGse2R7SqPWPXMNZvuD
	3yWV83kPKtkSc+ceN4gcVJJ2KOKY=
X-Google-Smtp-Source: AGHT+IG9/JWhBOL8Omyp8NUGd1UUZVWNuHnFFJQyZv7JsHKnltKoHW+S1qnZ5wvBRaO5VtnNhq+BIVGMVubi7VgM/Ak=
X-Received: by 2002:a17:90a:e7c8:b0:2d4:bf3:428e with SMTP id
 98e67ed59e1d1-2dd80ced376mr19669324a91.37.1727156702345; Mon, 23 Sep 2024
 22:45:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240722202758.3889061-1-jolsa@kernel.org> <20240722202758.3889061-3-jolsa@kernel.org>
 <w6U8Z9fdhjnkSp2UaFaV1fGqJXvfLEtDKEUyGDkwmoruDJ_AgF_c0FFhrkeKW18OqiP-05s9yDKiT6X-Ns-avN_ABf0dcUkXqbSJN1TQSXo=@pm.me>
In-Reply-To: <w6U8Z9fdhjnkSp2UaFaV1fGqJXvfLEtDKEUyGDkwmoruDJ_AgF_c0FFhrkeKW18OqiP-05s9yDKiT6X-Ns-avN_ABf0dcUkXqbSJN1TQSXo=@pm.me>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 24 Sep 2024 07:44:50 +0200
Message-ID: <CAEf4Bzb2dTK0jgc69O9Ouu3=5qeTT=RMAa3Na3V7LztN6y8bUw@mail.gmail.com>
Subject: Re: [PATCHv3 bpf-next 2/2] selftests/bpf: Add uprobe multi consumers test
To: Ihor Solodrai <ihor.solodrai@pm.me>
Cc: Jiri Olsa <jolsa@kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, 
	Martin KaFai Lau <kafai@fb.com>, Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>, 
	John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@chromium.org>, 
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, Oleg Nesterov <oleg@redhat.com>, 
	Peter Zijlstra <peterz@infradead.org>, Masami Hiramatsu <mhiramat@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 24, 2024 at 2:33=E2=80=AFAM Ihor Solodrai <ihor.solodrai@pm.me>=
 wrote:
>
> On Monday, July 22nd, 2024 at 1:27 PM, Jiri Olsa <jolsa@kernel.org> wrote=
:
>
> >
> >
> > Adding test that attaches/detaches multiple consumers on
> > single uprobe and verifies all were hit as expected.
> >
> > Signed-off-by: Jiri Olsa jolsa@kernel.org
> >
> > ---
> > .../bpf/prog_tests/uprobe_multi_test.c | 213 ++++++++++++++++++
> > .../bpf/progs/uprobe_multi_consumers.c | 39 ++++
> > 2 files changed, 252 insertions(+)
> > create mode 100644 tools/testing/selftests/bpf/progs/uprobe_multi_consu=
mers.c
> >
> > diff --git a/tools/testing/selftests/bpf/prog_tests/uprobe_multi_test.c=
 b/tools/testing/selftests/bpf/prog_tests/uprobe_multi_test.c
> > index e6255d4df81d..27708110ea20 100644
> > --- a/tools/testing/selftests/bpf/prog_tests/uprobe_multi_test.c
> > +++ b/tools/testing/selftests/bpf/prog_tests/uprobe_multi_test.c
> > @@ -6,6 +6,7 @@
> > #include "uprobe_multi.skel.h"
> > #include "uprobe_multi_bench.skel.h"
> > #include "uprobe_multi_usdt.skel.h"
> > +#include "uprobe_multi_consumers.skel.h"
> > #include "bpf/libbpf_internal.h"
> > #include "testing_helpers.h"
> > #include "../sdt.h"
> > @@ -731,6 +732,216 @@ static void test_link_api(void)
> > __test_link_api(child);
> > }
> >
>
> [...]
>
> > +
> > +static void consumer_test(struct uprobe_multi_consumers skel,
> > + unsigned long before, unsigned long after)
> > +{
> > + int err, idx;
> > +
> > + printf("consumer_test before %lu after %lu\n", before, after);
> > +
> > + / 'before' is each, we attach uprobe for every set idx */
> > + for (idx =3D 0; idx < 4; idx++) {
> > + if (test_bit(idx, before)) {
> > + if (!ASSERT_OK(uprobe_attach(skel, idx), "uprobe_attach_before"))
> > + goto cleanup;
> > + }
> > + }
> > +
> > + err =3D uprobe_consumer_test(skel, before, after);
> > + if (!ASSERT_EQ(err, 0, "uprobe_consumer_test"))
> > + goto cleanup;
> > +
> > + for (idx =3D 0; idx < 4; idx++) {
> > + const char fmt =3D "BUG";
> > + __u64 val =3D 0;
> > +
> > + if (idx < 2) {
> > + /
> > + * uprobe entry
> > + * +1 if define in 'before'
> > + /
> > + if (test_bit(idx, before))
> > + val++;
> > + fmt =3D "prog 0/1: uprobe";
> > + } else {
> > + /
> > + * uprobe return is tricky ;-)
> > + *
> > + * to trigger uretprobe consumer, the uretprobe needs to be installed,
> > + * which means one of the 'return' uprobes was alive when probe was hi=
t:
> > + *
> > + * idxs: 2/3 uprobe return in 'installed' mask
> > + *
> > + * in addition if 'after' state removes everything that was installed =
in
> > + * 'before' state, then uprobe kernel object goes away and return upro=
be
> > + * is not installed and we won't hit it even if it's in 'after' state.
> > + */
> > + unsigned long had_uretprobes =3D before & 0b1100; // is uretprobe ins=
talled
> > + unsigned long probe_preserved =3D before & after; // did uprobe go aw=
ay
> > +
> > + if (had_uretprobes && probe_preserved && test_bit(idx, after))
> > + val++;
> > + fmt =3D "idx 2/3: uretprobe";
> > + }
>
> Jiri, Andrii,
>
> This test case started failing since upstream got merged into bpf-next,
> starting from commit https://git.kernel.org/bpf/bpf-next/c/440b65232829
>
> A snippet from the test log:
>
>     consumer_test before 4 after 8
>     uprobe_attach:PASS:bpf_program__attach_uprobe_multi 0 nsec
>     consumer_test:PASS:uprobe_attach_before 0 nsec
>     uprobe_attach:PASS:bpf_program__attach_uprobe_multi 0 nsec
>     uprobe_consumer_test:PASS:uprobe_attach_after 0 nsec
>     consumer_test:PASS:uprobe_consumer_test 0 nsec
>     consumer_test:PASS:prog 0/1: uprobe 0 nsec
>     consumer_test:PASS:prog 0/1: uprobe 0 nsec
>     consumer_test:PASS:idx 2/3: uretprobe 0 nsec
>     consumer_test:FAIL:idx 2/3: uretprobe unexpected idx 2/3: uretprobe: =
actual 1 !=3D expected 0
>     consumer_test before 4 after 9
>     uprobe_attach:PASS:bpf_program__attach_uprobe_multi 0 nsec
>     consumer_test:PASS:uprobe_attach_before 0 nsec
>     uprobe_attach:PASS:bpf_program__attach_uprobe_multi 0 nsec
>     uprobe_consumer_test:PASS:uprobe_attach_after 0 nsec
>     uprobe_attach:PASS:bpf_program__attach_uprobe_multi 0 nsec
>     uprobe_consumer_test:PASS:uprobe_attach_after 0 nsec
>     consumer_test:PASS:uprobe_consumer_test 0 nsec
>     consumer_test:PASS:prog 0/1: uprobe 0 nsec
>     consumer_test:PASS:prog 0/1: uprobe 0 nsec
>     consumer_test:PASS:idx 2/3: uretprobe 0 nsec
>     consumer_test:FAIL:idx 2/3: uretprobe unexpected idx 2/3: uretprobe: =
actual 1 !=3D expected 0
>     consumer_test before 4 after 10
>     uprobe_attach:PASS:bpf_program__attach_uprobe_multi 0 nsec
>     consumer_test:PASS:uprobe_attach_before 0 nsec
>     uprobe_attach:PASS:bpf_program__attach_uprobe_multi 0 nsec
>     uprobe_consumer_test:PASS:uprobe_attach_after 0 nsec
>     uprobe_attach:PASS:bpf_program__attach_uprobe_multi 0 nsec
>     uprobe_consumer_test:PASS:uprobe_attach_after 0 nsec
>     consumer_test:PASS:uprobe_consumer_test 0 nsec
>     consumer_test:PASS:prog 0/1: uprobe 0 nsec
>     consumer_test:PASS:prog 0/1: uprobe 0 nsec
>     consumer_test:PASS:idx 2/3: uretprobe 0 nsec
>     consumer_test:FAIL:idx 2/3: uretprobe unexpected idx 2/3: uretprobe: =
actual 1 !=3D expected 0
>
>
> I couldn't figure out the reason as I have very shallow understanding
> of what's happening in the test.
>
> Jiri, could you please look into it?
>
> I excluded this test from BPF CI for now.

Thanks for the mitigation! I think this is due to my recent RCU and
refcounting changes to uprobes/uretprobes, which went through
tip/perf/core initially. And now that tip and bpf-next trees
converged, this condition:

  > unsigned long probe_preserved =3D before & after; // did uprobe go away

is no longer correct, and uretprobe can be activated if there was
*any* uretprobe installed before.

So the test needs adjustment, but I don't think anything really broke.
I don't remember exactly (and given the conferencing schedule and
quite bad internet can't test quickly), but I think the condition
should now be:

unsigned long probe_preserved =3D after & 0x1100;

(though we might want to also rename the variable to be a bit more
meaningful now).

Anyways, I don't think this is critical and we can address this later.
But if anyone is willing to send a fix, I'd appreciate it, of course!

>
> Thank you!
>
> > +
> > + ASSERT_EQ(skel->bss->uprobe_result[idx], val, fmt);
> >
> > + skel->bss->uprobe_result[idx] =3D 0;
> >
> > + }
> > +
> > +cleanup:
> > + for (idx =3D 0; idx < 4; idx++)
> > + uprobe_detach(skel, idx);
> > +}
>
> [...]
>

