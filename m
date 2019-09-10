Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5CBEAAE9D1
	for <lists+bpf@lfdr.de>; Tue, 10 Sep 2019 13:58:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726651AbfIJL5i (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 10 Sep 2019 07:57:38 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:37977 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731954AbfIJL4a (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 10 Sep 2019 07:56:30 -0400
Received: by mail-wr1-f67.google.com with SMTP id l11so19604751wrx.5
        for <bpf@vger.kernel.org>; Tue, 10 Sep 2019 04:56:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=neu1+SNcx3+JCL0eDuwZqNrNaVee6BTW6AWaLZCdbp4=;
        b=aE3lyKZ76kk0jH5fvUUBsWVhrptGL+yyoArZZ/LYIyxLKjUsI3xcSWR/3CoI7o4geo
         /i/t/VFvVXi5My78PegN4xOs3dR1JpxwoZJK569R3IIjMrNvWO5a39fQ7dv+f/dY3Fpn
         amkaj9Rl3iCRNkW23DZ49u7Fguh5Tf0RlWVOU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=neu1+SNcx3+JCL0eDuwZqNrNaVee6BTW6AWaLZCdbp4=;
        b=NgOe5ovrkiew49+QgQoI/I7SN/B+JpjQ5YXMy8xLbfO5Kx3IAN8aJOpR1mNTQvXlZk
         Bg//+Az0D/wTvAeflqp7X2S2U4wugGMN87x77cEiBPsaZ0oghBKadMVx77AXG5XXT2SZ
         P5eUlnZLs5kPSRaUGF8wFC+SDBlr6WhWCMzob4i1oas+Wy7ycs+RhZquIu1sQiBuc2w6
         XeCU3LTbMBjjTp6vUEC6ixtkHDj1MJ/rD6Dj3ZqLJ4i2zSKyhcziJUXd43ViHBsV0xyk
         G5OQ2Ige10Tif648gcyhATbQdgHd7las2jopy5+4kCJq7mrR1XRMbdW1wXF9OR2/I8h5
         hpVg==
X-Gm-Message-State: APjAAAUTKvnJC2zjA5ABYYzEOkduYv6rLrOKQgkxMtvS7UQYCoI5yzv+
        T1ERvHZGd2EFel7FvZZ+jp4mBQ==
X-Google-Smtp-Source: APXvYqz0I8AKSm98TOHLRk9qzO54R/9/vbhmrvD8H96WG5P1Y90KCbbnzpJnNJ733VZXkbnkVhXZGA==
X-Received: by 2002:adf:ce81:: with SMTP id r1mr25914250wrn.114.1568116588890;
        Tue, 10 Sep 2019 04:56:28 -0700 (PDT)
Received: from kpsingh-kernel.c.hoisthospitality.com (110.8.30.213.rev.vodafone.pt. [213.30.8.110])
        by smtp.gmail.com with ESMTPSA id q19sm23732935wra.89.2019.09.10.04.56.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Sep 2019 04:56:28 -0700 (PDT)
From:   KP Singh <kpsingh@chromium.org>
To:     linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
        linux-security-module@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        James Morris <jmorris@namei.org>,
        Kees Cook <keescook@chromium.org>,
        Thomas Garnier <thgarnie@chromium.org>,
        Michael Halcrow <mhalcrow@google.com>,
        Paul Turner <pjt@google.com>,
        Brendan Gregg <brendan.d.gregg@gmail.com>,
        Jann Horn <jannh@google.com>,
        Matthew Garrett <mjg59@google.com>,
        Christian Brauner <christian@brauner.io>,
        =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
        Florent Revest <revest@chromium.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Stanislav Fomichev <sdf@google.com>,
        Quentin Monnet <quentin.monnet@netronome.com>,
        Andrey Ignatov <rdna@fb.com>, Joe Stringer <joe@wand.net.nz>
Subject: [RFC v1 04/14] krsi: Add support in libbpf for BPF_PROG_TYPE_KRSI
Date:   Tue, 10 Sep 2019 13:55:17 +0200
Message-Id: <20190910115527.5235-5-kpsingh@chromium.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190910115527.5235-1-kpsingh@chromium.org>
References: <20190910115527.5235-1-kpsingh@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: KP Singh <kpsingh@google.com>

Update the libbpf library with functionality to load and
attach a program type BPF_PROG_TYPE_KRSI.

Since the bpf_prog_load does not allow the specification of an
expected attach type, it's recommended to use bpf_prog_load_xattr and
set the expected attach type as KRSI.

Signed-off-by: KP Singh <kpsingh@google.com>
---
 tools/lib/bpf/libbpf.c        | 4 ++++
 tools/lib/bpf/libbpf.h        | 2 ++
 tools/lib/bpf/libbpf.map      | 2 ++
 tools/lib/bpf/libbpf_probes.c | 1 +
 4 files changed, 9 insertions(+)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 2b57d7ea7836..3cc86bbc68cd 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -2676,6 +2676,7 @@ static bool bpf_prog_type__needs_kver(enum bpf_prog_type type)
 	case BPF_PROG_TYPE_PERF_EVENT:
 	case BPF_PROG_TYPE_CGROUP_SYSCTL:
 	case BPF_PROG_TYPE_CGROUP_SOCKOPT:
+	case BPF_PROG_TYPE_KRSI:
 		return false;
 	case BPF_PROG_TYPE_KPROBE:
 	default:
@@ -3536,6 +3537,7 @@ bool bpf_program__is_##NAME(const struct bpf_program *prog)	\
 }								\
 
 BPF_PROG_TYPE_FNS(socket_filter, BPF_PROG_TYPE_SOCKET_FILTER);
+BPF_PROG_TYPE_FNS(krsi, BPF_PROG_TYPE_KRSI);
 BPF_PROG_TYPE_FNS(kprobe, BPF_PROG_TYPE_KPROBE);
 BPF_PROG_TYPE_FNS(sched_cls, BPF_PROG_TYPE_SCHED_CLS);
 BPF_PROG_TYPE_FNS(sched_act, BPF_PROG_TYPE_SCHED_ACT);
@@ -3590,6 +3592,8 @@ static const struct {
 	BPF_PROG_SEC("lwt_out",			BPF_PROG_TYPE_LWT_OUT),
 	BPF_PROG_SEC("lwt_xmit",		BPF_PROG_TYPE_LWT_XMIT),
 	BPF_PROG_SEC("lwt_seg6local",		BPF_PROG_TYPE_LWT_SEG6LOCAL),
+	BPF_APROG_SEC("krsi",			BPF_PROG_TYPE_KRSI,
+						BPF_KRSI),
 	BPF_APROG_SEC("cgroup_skb/ingress",	BPF_PROG_TYPE_CGROUP_SKB,
 						BPF_CGROUP_INET_INGRESS),
 	BPF_APROG_SEC("cgroup_skb/egress",	BPF_PROG_TYPE_CGROUP_SKB,
diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
index 5cbf459ece0b..8781d29b4035 100644
--- a/tools/lib/bpf/libbpf.h
+++ b/tools/lib/bpf/libbpf.h
@@ -261,6 +261,7 @@ LIBBPF_API int bpf_program__set_sched_cls(struct bpf_program *prog);
 LIBBPF_API int bpf_program__set_sched_act(struct bpf_program *prog);
 LIBBPF_API int bpf_program__set_xdp(struct bpf_program *prog);
 LIBBPF_API int bpf_program__set_perf_event(struct bpf_program *prog);
+LIBBPF_API int bpf_program__set_krsi(struct bpf_program *prog);
 LIBBPF_API void bpf_program__set_type(struct bpf_program *prog,
 				      enum bpf_prog_type type);
 LIBBPF_API void
@@ -275,6 +276,7 @@ LIBBPF_API bool bpf_program__is_sched_cls(const struct bpf_program *prog);
 LIBBPF_API bool bpf_program__is_sched_act(const struct bpf_program *prog);
 LIBBPF_API bool bpf_program__is_xdp(const struct bpf_program *prog);
 LIBBPF_API bool bpf_program__is_perf_event(const struct bpf_program *prog);
+LIBBPF_API bool bpf_program__is_krsi(const struct bpf_program *prog);
 
 /*
  * No need for __attribute__((packed)), all members of 'bpf_map_def'
diff --git a/tools/lib/bpf/libbpf.map b/tools/lib/bpf/libbpf.map
index f9d316e873d8..75b8fe419c11 100644
--- a/tools/lib/bpf/libbpf.map
+++ b/tools/lib/bpf/libbpf.map
@@ -68,6 +68,7 @@ LIBBPF_0.0.1 {
 		bpf_prog_test_run_xattr;
 		bpf_program__fd;
 		bpf_program__is_kprobe;
+		bpf_program__is_krsi;
 		bpf_program__is_perf_event;
 		bpf_program__is_raw_tracepoint;
 		bpf_program__is_sched_act;
@@ -85,6 +86,7 @@ LIBBPF_0.0.1 {
 		bpf_program__set_expected_attach_type;
 		bpf_program__set_ifindex;
 		bpf_program__set_kprobe;
+		bpf_program__set_krsi;
 		bpf_program__set_perf_event;
 		bpf_program__set_prep;
 		bpf_program__set_priv;
diff --git a/tools/lib/bpf/libbpf_probes.c b/tools/lib/bpf/libbpf_probes.c
index ace1a0708d99..cc515a36794d 100644
--- a/tools/lib/bpf/libbpf_probes.c
+++ b/tools/lib/bpf/libbpf_probes.c
@@ -102,6 +102,7 @@ probe_load(enum bpf_prog_type prog_type, const struct bpf_insn *insns,
 	case BPF_PROG_TYPE_FLOW_DISSECTOR:
 	case BPF_PROG_TYPE_CGROUP_SYSCTL:
 	case BPF_PROG_TYPE_CGROUP_SOCKOPT:
+	case BPF_PROG_TYPE_KRSI:
 	default:
 		break;
 	}
-- 
2.20.1

