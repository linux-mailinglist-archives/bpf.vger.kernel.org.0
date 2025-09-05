Return-Path: <bpf+bounces-67653-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B9FCB466D8
	for <lists+bpf@lfdr.de>; Sat,  6 Sep 2025 00:48:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C69A2588A75
	for <lists+bpf@lfdr.de>; Fri,  5 Sep 2025 22:48:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBB8C29CB4D;
	Fri,  5 Sep 2025 22:47:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="25gQXJ9y"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60BCE2C326B
	for <bpf@vger.kernel.org>; Fri,  5 Sep 2025 22:47:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757112474; cv=none; b=RUE5RquI6oUY61hCOfrjKvqMTCgp/MjAprezbJpJryADwNFN9tH2avcHsjjtNRDFKYztUYOAXvql2CmLFJUvsZAS5NruN/m4FlDfj895+YOIsTHIAw3CgdHZBGLZo6EAaqxEI7QV2cB5bJdT8+96sdIKFQ3W2lG7keh6iYG3b1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757112474; c=relaxed/simple;
	bh=KkBdy1tDUbVSRPtNS5cH1JB02V9BameG8su8CzxK5HE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=GeZObXoc/UHvpEsYVthuC0RV+lv/avAc/jynpNjESlpmNzfmTIYafvhyDWjmrqAH2AH1rexcu+9t9kMr3vTyLH3RcW0WMqK383RxVwXylWkG/d117DH7vTFgJN81Peza+wG7c8AHcSZsNzCjeW8ozL+yJZ7w160MsXwlVCav/hw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=25gQXJ9y; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-329ee69e7f1so2266502a91.1
        for <bpf@vger.kernel.org>; Fri, 05 Sep 2025 15:47:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757112470; x=1757717270; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cj3U4KAk6QAsI3xFCToPdbB7Z80o0zZD/0MCtfOENa8=;
        b=25gQXJ9yJICMskixsKXVFsx/LS8lS/6tiS/hj3qO3bct5vmAxP8x8cm1dvA6eKyY/Z
         OZodjvUrLkUq1vH5qO+STgSudUgbUjHCzQDLDV+dUtLM0v111UZBMYKCyEmXL1+mecpq
         /pal2qydRV4/dTY/hgzZ4Qo15bza+L13Gxg8dfC4TPvg3c1aczTpjyO6zbrmr08zpNUU
         AHEKtaVBws6m9SW+PXGd3ZPE/JHMzr4GyzQ1hNuSGJ9ev1AYvADh45YN0CurBwOlKAhy
         bD8NMD12hGB3SmZf1qqfVfxwwpQE34L4pic/oyoB6HvfK19mu3KcppASpKQ+7sxoSAsf
         +jMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757112470; x=1757717270;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cj3U4KAk6QAsI3xFCToPdbB7Z80o0zZD/0MCtfOENa8=;
        b=t/vmXz1xeAz75Zdz7qFR0L8XFREsJBVFVeiJWqf/WXvcoFDGIl2lTLiFeXOhAkkTbx
         cmwprfk8eZtYB+SpcvFPB5TtvGO3bkQpMsT5J4lFMYl0Tf1JTckRtlODh0kFpVN4biOw
         DTCM2+oVhpRh95UdOZt/XSZxJstg2XA+xzvYVlEIS2lMPnHJc5EyOtVvu8bProhRAy0F
         TOfKmuHwLzuhiSqdg9lHGXCRCoswTclzmprkXTyldCuOSu29SCWKML/iDLFOwkt32/Xj
         WgtNVIRdNvOXI1PN+jUopq47Veuzzt6IuUDkmQR1JZs3wDoCaYGGomQO8pfm5Se+JrHY
         X44g==
X-Forwarded-Encrypted: i=1; AJvYcCVZE6nMUSmd9VBCMOjpCaaw29i45xpLOBL0JTK5FNaT8LlH0nAyNlidZyb2gI604W0Adrs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwY/CcCmzLaLbZpjnlkbaJKpqS8HwDBOU9KKN+9XbF9bWNGWsIf
	jSGEUb+RG53gTjYuY+ytkWp1N2NmnNunGZZGriCwyuZWMuqUOZToPn49q5XfPuBNSU0w5EOzvPF
	3ykqZ9QTb9Q==
X-Google-Smtp-Source: AGHT+IHN8YE8oW3kdF1gSah74i6kd46TtSOAh8KY6MJOcb3LS84wtDCUUYhw+UGd8TuK4ARVLrqTHYuV2Fy1
X-Received: from pja5.prod.google.com ([2002:a17:90b:5485:b0:32b:8ba7:306a])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:1343:b0:32b:58d4:e9d0
 with SMTP id 98e67ed59e1d1-32d43f98ca9mr569280a91.23.1757112469753; Fri, 05
 Sep 2025 15:47:49 -0700 (PDT)
Date: Fri,  5 Sep 2025 15:47:08 -0700
In-Reply-To: <20250905224708.2469021-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250905224708.2469021-1-irogers@google.com>
X-Mailer: git-send-email 2.51.0.355.g5224444f11-goog
Message-ID: <20250905224708.2469021-5-irogers@google.com>
Subject: [PATCH v1 4/4] tools include: Add headers to make tools builds more hermetic
From: Ian Rogers <irogers@google.com>
To: Yury Norov <yury.norov@gmail.com>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
	Peter Zijlstra <peterz@infradead.org>, Darren Hart <dvhart@infradead.org>, 
	Davidlohr Bueso <dave@stgolabs.net>, 
	"=?UTF-8?q?Andr=C3=A9=20Almeida?=" <andrealmeid@igalia.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, 
	Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Ido Schimmel <idosch@nvidia.com>, 
	Jakub Kicinski <kuba@kernel.org>, Jamal Hadi Salim <jhs@mojatatu.com>, 
	Jason Xing <kerneljasonxing@gmail.com>, Daniel Borkmann <daniel@iogearbox.net>, 
	Yuyang Huang <yuyanghuang@google.com>, Paolo Abeni <pabeni@redhat.com>, 
	"David S. Miller" <davem@davemloft.net>, Petr Machata <petrm@nvidia.com>, 
	Maurice Lambert <mauricelambert434@gmail.com>, Jonas Gottlieb <jonas.gottlieb@stackit.cloud>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

tools/lib/bpf/netlink.c depends on rtnetlink.h and genetlink.h (via
nlattr.h) which then depends on if_addr.h.

tools/bpf/bpftool/link.c depends on netfilter_arp.h which then depends
on netfilter.h.

Update check-headers.sh to keep these in sync.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/include/uapi/linux/genetlink.h     | 103 +++
 tools/include/uapi/linux/if_addr.h       |  79 +++
 tools/include/uapi/linux/neighbour.h     | 229 ++++++
 tools/include/uapi/linux/netfilter.h     |  80 +++
 tools/include/uapi/linux/netfilter_arp.h |  23 +
 tools/include/uapi/linux/rtnetlink.h     | 848 +++++++++++++++++++++++
 tools/perf/check-headers.sh              |   8 +-
 7 files changed, 1369 insertions(+), 1 deletion(-)
 create mode 100644 tools/include/uapi/linux/genetlink.h
 create mode 100644 tools/include/uapi/linux/if_addr.h
 create mode 100644 tools/include/uapi/linux/neighbour.h
 create mode 100644 tools/include/uapi/linux/netfilter.h
 create mode 100644 tools/include/uapi/linux/netfilter_arp.h
 create mode 100644 tools/include/uapi/linux/rtnetlink.h

diff --git a/tools/include/uapi/linux/genetlink.h b/tools/include/uapi/linux/genetlink.h
new file mode 100644
index 000000000000..ddba3ca01e39
--- /dev/null
+++ b/tools/include/uapi/linux/genetlink.h
@@ -0,0 +1,103 @@
+/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
+#ifndef _UAPI__LINUX_GENERIC_NETLINK_H
+#define _UAPI__LINUX_GENERIC_NETLINK_H
+
+#include <linux/types.h>
+#include <linux/netlink.h>
+
+#define GENL_NAMSIZ	16	/* length of family name */
+
+#define GENL_MIN_ID	NLMSG_MIN_TYPE
+#define GENL_MAX_ID	1023
+
+struct genlmsghdr {
+	__u8	cmd;
+	__u8	version;
+	__u16	reserved;
+};
+
+#define GENL_HDRLEN	NLMSG_ALIGN(sizeof(struct genlmsghdr))
+
+#define GENL_ADMIN_PERM		0x01
+#define GENL_CMD_CAP_DO		0x02
+#define GENL_CMD_CAP_DUMP	0x04
+#define GENL_CMD_CAP_HASPOL	0x08
+#define GENL_UNS_ADMIN_PERM	0x10
+
+/*
+ * List of reserved static generic netlink identifiers:
+ */
+#define GENL_ID_CTRL		NLMSG_MIN_TYPE
+#define GENL_ID_VFS_DQUOT	(NLMSG_MIN_TYPE + 1)
+#define GENL_ID_PMCRAID		(NLMSG_MIN_TYPE + 2)
+/* must be last reserved + 1 */
+#define GENL_START_ALLOC	(NLMSG_MIN_TYPE + 3)
+
+/**************************************************************************
+ * Controller
+ **************************************************************************/
+
+enum {
+	CTRL_CMD_UNSPEC,
+	CTRL_CMD_NEWFAMILY,
+	CTRL_CMD_DELFAMILY,
+	CTRL_CMD_GETFAMILY,
+	CTRL_CMD_NEWOPS,
+	CTRL_CMD_DELOPS,
+	CTRL_CMD_GETOPS,
+	CTRL_CMD_NEWMCAST_GRP,
+	CTRL_CMD_DELMCAST_GRP,
+	CTRL_CMD_GETMCAST_GRP, /* unused */
+	CTRL_CMD_GETPOLICY,
+	__CTRL_CMD_MAX,
+};
+
+#define CTRL_CMD_MAX (__CTRL_CMD_MAX - 1)
+
+enum {
+	CTRL_ATTR_UNSPEC,
+	CTRL_ATTR_FAMILY_ID,
+	CTRL_ATTR_FAMILY_NAME,
+	CTRL_ATTR_VERSION,
+	CTRL_ATTR_HDRSIZE,
+	CTRL_ATTR_MAXATTR,
+	CTRL_ATTR_OPS,
+	CTRL_ATTR_MCAST_GROUPS,
+	CTRL_ATTR_POLICY,
+	CTRL_ATTR_OP_POLICY,
+	CTRL_ATTR_OP,
+	__CTRL_ATTR_MAX,
+};
+
+#define CTRL_ATTR_MAX (__CTRL_ATTR_MAX - 1)
+
+enum {
+	CTRL_ATTR_OP_UNSPEC,
+	CTRL_ATTR_OP_ID,
+	CTRL_ATTR_OP_FLAGS,
+	__CTRL_ATTR_OP_MAX,
+};
+
+#define CTRL_ATTR_OP_MAX (__CTRL_ATTR_OP_MAX - 1)
+
+enum {
+	CTRL_ATTR_MCAST_GRP_UNSPEC,
+	CTRL_ATTR_MCAST_GRP_NAME,
+	CTRL_ATTR_MCAST_GRP_ID,
+	__CTRL_ATTR_MCAST_GRP_MAX,
+};
+
+#define CTRL_ATTR_MCAST_GRP_MAX (__CTRL_ATTR_MCAST_GRP_MAX - 1)
+
+enum {
+	CTRL_ATTR_POLICY_UNSPEC,
+	CTRL_ATTR_POLICY_DO,
+	CTRL_ATTR_POLICY_DUMP,
+
+	__CTRL_ATTR_POLICY_DUMP_MAX,
+	CTRL_ATTR_POLICY_DUMP_MAX = __CTRL_ATTR_POLICY_DUMP_MAX - 1
+};
+
+#define CTRL_ATTR_POLICY_MAX (__CTRL_ATTR_POLICY_DUMP_MAX - 1)
+
+#endif /* _UAPI__LINUX_GENERIC_NETLINK_H */
diff --git a/tools/include/uapi/linux/if_addr.h b/tools/include/uapi/linux/if_addr.h
new file mode 100644
index 000000000000..aa7958b4e41d
--- /dev/null
+++ b/tools/include/uapi/linux/if_addr.h
@@ -0,0 +1,79 @@
+/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
+#ifndef _UAPI__LINUX_IF_ADDR_H
+#define _UAPI__LINUX_IF_ADDR_H
+
+#include <linux/types.h>
+#include <linux/netlink.h>
+
+struct ifaddrmsg {
+	__u8		ifa_family;
+	__u8		ifa_prefixlen;	/* The prefix length		*/
+	__u8		ifa_flags;	/* Flags			*/
+	__u8		ifa_scope;	/* Address scope		*/
+	__u32		ifa_index;	/* Link index			*/
+};
+
+/*
+ * Important comment:
+ * IFA_ADDRESS is prefix address, rather than local interface address.
+ * It makes no difference for normally configured broadcast interfaces,
+ * but for point-to-point IFA_ADDRESS is DESTINATION address,
+ * local address is supplied in IFA_LOCAL attribute.
+ *
+ * IFA_FLAGS is a u32 attribute that extends the u8 field ifa_flags.
+ * If present, the value from struct ifaddrmsg will be ignored.
+ */
+enum {
+	IFA_UNSPEC,
+	IFA_ADDRESS,
+	IFA_LOCAL,
+	IFA_LABEL,
+	IFA_BROADCAST,
+	IFA_ANYCAST,
+	IFA_CACHEINFO,
+	IFA_MULTICAST,
+	IFA_FLAGS,
+	IFA_RT_PRIORITY,	/* u32, priority/metric for prefix route */
+	IFA_TARGET_NETNSID,
+	IFA_PROTO,		/* u8, address protocol */
+	__IFA_MAX,
+};
+
+#define IFA_MAX (__IFA_MAX - 1)
+
+/* ifa_flags */
+#define IFA_F_SECONDARY		0x01
+#define IFA_F_TEMPORARY		IFA_F_SECONDARY
+
+#define	IFA_F_NODAD		0x02
+#define IFA_F_OPTIMISTIC	0x04
+#define IFA_F_DADFAILED		0x08
+#define	IFA_F_HOMEADDRESS	0x10
+#define IFA_F_DEPRECATED	0x20
+#define IFA_F_TENTATIVE		0x40
+#define IFA_F_PERMANENT		0x80
+#define IFA_F_MANAGETEMPADDR	0x100
+#define IFA_F_NOPREFIXROUTE	0x200
+#define IFA_F_MCAUTOJOIN	0x400
+#define IFA_F_STABLE_PRIVACY	0x800
+
+struct ifa_cacheinfo {
+	__u32	ifa_prefered;
+	__u32	ifa_valid;
+	__u32	cstamp; /* created timestamp, hundredths of seconds */
+	__u32	tstamp; /* updated timestamp, hundredths of seconds */
+};
+
+/* backwards compatibility for userspace */
+#ifndef __KERNEL__
+#define IFA_RTA(r)  ((struct rtattr*)(((char*)(r)) + NLMSG_ALIGN(sizeof(struct ifaddrmsg))))
+#define IFA_PAYLOAD(n) NLMSG_PAYLOAD(n,sizeof(struct ifaddrmsg))
+#endif
+
+/* ifa_proto */
+#define IFAPROT_UNSPEC		0
+#define IFAPROT_KERNEL_LO	1	/* loopback */
+#define IFAPROT_KERNEL_RA	2	/* set by kernel from router announcement */
+#define IFAPROT_KERNEL_LL	3	/* link-local set by kernel */
+
+#endif
diff --git a/tools/include/uapi/linux/neighbour.h b/tools/include/uapi/linux/neighbour.h
new file mode 100644
index 000000000000..c34a81245f87
--- /dev/null
+++ b/tools/include/uapi/linux/neighbour.h
@@ -0,0 +1,229 @@
+/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
+#ifndef _UAPI__LINUX_NEIGHBOUR_H
+#define _UAPI__LINUX_NEIGHBOUR_H
+
+#include <linux/types.h>
+#include <linux/netlink.h>
+
+struct ndmsg {
+	__u8		ndm_family;
+	__u8		ndm_pad1;
+	__u16		ndm_pad2;
+	__s32		ndm_ifindex;
+	__u16		ndm_state;
+	__u8		ndm_flags;
+	__u8		ndm_type;
+};
+
+enum {
+	NDA_UNSPEC,
+	NDA_DST,
+	NDA_LLADDR,
+	NDA_CACHEINFO,
+	NDA_PROBES,
+	NDA_VLAN,
+	NDA_PORT,
+	NDA_VNI,
+	NDA_IFINDEX,
+	NDA_MASTER,
+	NDA_LINK_NETNSID,
+	NDA_SRC_VNI,
+	NDA_PROTOCOL,  /* Originator of entry */
+	NDA_NH_ID,
+	NDA_FDB_EXT_ATTRS,
+	NDA_FLAGS_EXT,
+	NDA_NDM_STATE_MASK,
+	NDA_NDM_FLAGS_MASK,
+	__NDA_MAX
+};
+
+#define NDA_MAX (__NDA_MAX - 1)
+
+/*
+ *	Neighbor Cache Entry Flags
+ */
+
+#define NTF_USE		(1 << 0)
+#define NTF_SELF	(1 << 1)
+#define NTF_MASTER	(1 << 2)
+#define NTF_PROXY	(1 << 3)	/* == ATF_PUBL */
+#define NTF_EXT_LEARNED	(1 << 4)
+#define NTF_OFFLOADED   (1 << 5)
+#define NTF_STICKY	(1 << 6)
+#define NTF_ROUTER	(1 << 7)
+/* Extended flags under NDA_FLAGS_EXT: */
+#define NTF_EXT_MANAGED		(1 << 0)
+#define NTF_EXT_LOCKED		(1 << 1)
+#define NTF_EXT_EXT_VALIDATED	(1 << 2)
+
+/*
+ *	Neighbor Cache Entry States.
+ */
+
+#define NUD_INCOMPLETE	0x01
+#define NUD_REACHABLE	0x02
+#define NUD_STALE	0x04
+#define NUD_DELAY	0x08
+#define NUD_PROBE	0x10
+#define NUD_FAILED	0x20
+
+/* Dummy states */
+#define NUD_NOARP	0x40
+#define NUD_PERMANENT	0x80
+#define NUD_NONE	0x00
+
+/* NUD_NOARP & NUD_PERMANENT are pseudostates, they never change and make no
+ * address resolution or NUD.
+ *
+ * NUD_PERMANENT also cannot be deleted by garbage collectors. This holds true
+ * for dynamic entries with NTF_EXT_LEARNED flag as well. However, upon carrier
+ * down event, NUD_PERMANENT entries are not flushed whereas NTF_EXT_LEARNED
+ * flagged entries explicitly are (which is also consistent with the routing
+ * subsystem).
+ *
+ * When NTF_EXT_LEARNED is set for a bridge fdb entry the different cache entry
+ * states don't make sense and thus are ignored. Such entries don't age and
+ * can roam.
+ *
+ * NTF_EXT_MANAGED flagged neigbor entries are managed by the kernel on behalf
+ * of a user space control plane, and automatically refreshed so that (if
+ * possible) they remain in NUD_REACHABLE state.
+ *
+ * NTF_EXT_LOCKED flagged bridge FDB entries are entries generated by the
+ * bridge in response to a host trying to communicate via a locked bridge port
+ * with MAB enabled. Their purpose is to notify user space that a host requires
+ * authentication.
+ *
+ * NTF_EXT_EXT_VALIDATED flagged neighbor entries were externally validated by
+ * a user space control plane. The kernel will not remove or invalidate them,
+ * but it can probe them and notify user space when they become reachable.
+ */
+
+struct nda_cacheinfo {
+	__u32		ndm_confirmed;
+	__u32		ndm_used;
+	__u32		ndm_updated;
+	__u32		ndm_refcnt;
+};
+
+/*****************************************************************
+ *		Neighbour tables specific messages.
+ *
+ * To retrieve the neighbour tables send RTM_GETNEIGHTBL with the
+ * NLM_F_DUMP flag set. Every neighbour table configuration is
+ * spread over multiple messages to avoid running into message
+ * size limits on systems with many interfaces. The first message
+ * in the sequence transports all not device specific data such as
+ * statistics, configuration, and the default parameter set.
+ * This message is followed by 0..n messages carrying device
+ * specific parameter sets.
+ * Although the ordering should be sufficient, NDTA_NAME can be
+ * used to identify sequences. The initial message can be identified
+ * by checking for NDTA_CONFIG. The device specific messages do
+ * not contain this TLV but have NDTPA_IFINDEX set to the
+ * corresponding interface index.
+ *
+ * To change neighbour table attributes, send RTM_SETNEIGHTBL
+ * with NDTA_NAME set. Changeable attribute include NDTA_THRESH[1-3],
+ * NDTA_GC_INTERVAL, and all TLVs in NDTA_PARMS unless marked
+ * otherwise. Device specific parameter sets can be changed by
+ * setting NDTPA_IFINDEX to the interface index of the corresponding
+ * device.
+ ****/
+
+struct ndt_stats {
+	__u64		ndts_allocs;
+	__u64		ndts_destroys;
+	__u64		ndts_hash_grows;
+	__u64		ndts_res_failed;
+	__u64		ndts_lookups;
+	__u64		ndts_hits;
+	__u64		ndts_rcv_probes_mcast;
+	__u64		ndts_rcv_probes_ucast;
+	__u64		ndts_periodic_gc_runs;
+	__u64		ndts_forced_gc_runs;
+	__u64		ndts_table_fulls;
+};
+
+enum {
+	NDTPA_UNSPEC,
+	NDTPA_IFINDEX,			/* u32, unchangeable */
+	NDTPA_REFCNT,			/* u32, read-only */
+	NDTPA_REACHABLE_TIME,		/* u64, read-only, msecs */
+	NDTPA_BASE_REACHABLE_TIME,	/* u64, msecs */
+	NDTPA_RETRANS_TIME,		/* u64, msecs */
+	NDTPA_GC_STALETIME,		/* u64, msecs */
+	NDTPA_DELAY_PROBE_TIME,		/* u64, msecs */
+	NDTPA_QUEUE_LEN,		/* u32 */
+	NDTPA_APP_PROBES,		/* u32 */
+	NDTPA_UCAST_PROBES,		/* u32 */
+	NDTPA_MCAST_PROBES,		/* u32 */
+	NDTPA_ANYCAST_DELAY,		/* u64, msecs */
+	NDTPA_PROXY_DELAY,		/* u64, msecs */
+	NDTPA_PROXY_QLEN,		/* u32 */
+	NDTPA_LOCKTIME,			/* u64, msecs */
+	NDTPA_QUEUE_LENBYTES,		/* u32 */
+	NDTPA_MCAST_REPROBES,		/* u32 */
+	NDTPA_PAD,
+	NDTPA_INTERVAL_PROBE_TIME_MS,	/* u64, msecs */
+	__NDTPA_MAX
+};
+#define NDTPA_MAX (__NDTPA_MAX - 1)
+
+struct ndtmsg {
+	__u8		ndtm_family;
+	__u8		ndtm_pad1;
+	__u16		ndtm_pad2;
+};
+
+struct ndt_config {
+	__u16		ndtc_key_len;
+	__u16		ndtc_entry_size;
+	__u32		ndtc_entries;
+	__u32		ndtc_last_flush;	/* delta to now in msecs */
+	__u32		ndtc_last_rand;		/* delta to now in msecs */
+	__u32		ndtc_hash_rnd;
+	__u32		ndtc_hash_mask;
+	__u32		ndtc_hash_chain_gc;
+	__u32		ndtc_proxy_qlen;
+};
+
+enum {
+	NDTA_UNSPEC,
+	NDTA_NAME,			/* char *, unchangeable */
+	NDTA_THRESH1,			/* u32 */
+	NDTA_THRESH2,			/* u32 */
+	NDTA_THRESH3,			/* u32 */
+	NDTA_CONFIG,			/* struct ndt_config, read-only */
+	NDTA_PARMS,			/* nested TLV NDTPA_* */
+	NDTA_STATS,			/* struct ndt_stats, read-only */
+	NDTA_GC_INTERVAL,		/* u64, msecs */
+	NDTA_PAD,
+	__NDTA_MAX
+};
+#define NDTA_MAX (__NDTA_MAX - 1)
+
+ /* FDB activity notification bits used in NFEA_ACTIVITY_NOTIFY:
+  * - FDB_NOTIFY_BIT - notify on activity/expire for any entry
+  * - FDB_NOTIFY_INACTIVE_BIT - mark as inactive to avoid multiple notifications
+  */
+enum {
+	FDB_NOTIFY_BIT		= (1 << 0),
+	FDB_NOTIFY_INACTIVE_BIT	= (1 << 1)
+};
+
+/* embedded into NDA_FDB_EXT_ATTRS:
+ * [NDA_FDB_EXT_ATTRS] = {
+ *     [NFEA_ACTIVITY_NOTIFY]
+ *     ...
+ * }
+ */
+enum {
+	NFEA_UNSPEC,
+	NFEA_ACTIVITY_NOTIFY,
+	NFEA_DONT_REFRESH,
+	__NFEA_MAX
+};
+#define NFEA_MAX (__NFEA_MAX - 1)
+
+#endif
diff --git a/tools/include/uapi/linux/netfilter.h b/tools/include/uapi/linux/netfilter.h
new file mode 100644
index 000000000000..5a79ccb76701
--- /dev/null
+++ b/tools/include/uapi/linux/netfilter.h
@@ -0,0 +1,80 @@
+/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
+#ifndef _UAPI__LINUX_NETFILTER_H
+#define _UAPI__LINUX_NETFILTER_H
+
+#include <linux/types.h>
+#include <linux/compiler.h>
+#include <linux/in.h>
+#include <linux/in6.h>
+
+/* Responses from hook functions. */
+#define NF_DROP 0
+#define NF_ACCEPT 1
+#define NF_STOLEN 2
+#define NF_QUEUE 3
+#define NF_REPEAT 4
+#define NF_STOP 5	/* Deprecated, for userspace nf_queue compatibility. */
+#define NF_MAX_VERDICT NF_STOP
+
+/* we overload the higher bits for encoding auxiliary data such as the queue
+ * number or errno values. Not nice, but better than additional function
+ * arguments. */
+#define NF_VERDICT_MASK 0x000000ff
+
+/* extra verdict flags have mask 0x0000ff00 */
+#define NF_VERDICT_FLAG_QUEUE_BYPASS	0x00008000
+
+/* queue number (NF_QUEUE) or errno (NF_DROP) */
+#define NF_VERDICT_QMASK 0xffff0000
+#define NF_VERDICT_QBITS 16
+
+#define NF_QUEUE_NR(x) ((((x) << 16) & NF_VERDICT_QMASK) | NF_QUEUE)
+
+#define NF_DROP_ERR(x) (((-x) << 16) | NF_DROP)
+
+/* only for userspace compatibility */
+#ifndef __KERNEL__
+
+/* NF_VERDICT_BITS should be 8 now, but userspace might break if this changes */
+#define NF_VERDICT_BITS 16
+#endif
+
+enum nf_inet_hooks {
+	NF_INET_PRE_ROUTING,
+	NF_INET_LOCAL_IN,
+	NF_INET_FORWARD,
+	NF_INET_LOCAL_OUT,
+	NF_INET_POST_ROUTING,
+	NF_INET_NUMHOOKS,
+	NF_INET_INGRESS = NF_INET_NUMHOOKS,
+};
+
+enum nf_dev_hooks {
+	NF_NETDEV_INGRESS,
+	NF_NETDEV_EGRESS,
+	NF_NETDEV_NUMHOOKS
+};
+
+enum {
+	NFPROTO_UNSPEC =  0,
+	NFPROTO_INET   =  1,
+	NFPROTO_IPV4   =  2,
+	NFPROTO_ARP    =  3,
+	NFPROTO_NETDEV =  5,
+	NFPROTO_BRIDGE =  7,
+	NFPROTO_IPV6   = 10,
+#ifndef __KERNEL__ /* no longer supported by kernel */
+	NFPROTO_DECNET = 12,
+#endif
+	NFPROTO_NUMPROTO,
+};
+
+union nf_inet_addr {
+	__u32		all[4];
+	__be32		ip;
+	__be32		ip6[4];
+	struct in_addr	in;
+	struct in6_addr	in6;
+};
+
+#endif /* _UAPI__LINUX_NETFILTER_H */
diff --git a/tools/include/uapi/linux/netfilter_arp.h b/tools/include/uapi/linux/netfilter_arp.h
new file mode 100644
index 000000000000..791dfc5ae907
--- /dev/null
+++ b/tools/include/uapi/linux/netfilter_arp.h
@@ -0,0 +1,23 @@
+/* SPDX-License-Identifier: GPL-1.0+ WITH Linux-syscall-note */
+#ifndef __LINUX_ARP_NETFILTER_H
+#define __LINUX_ARP_NETFILTER_H
+
+/* ARP-specific defines for netfilter.
+ * (C)2002 Rusty Russell IBM -- This code is GPL.
+ */
+
+#include <linux/netfilter.h>
+
+/* There is no PF_ARP. */
+#define NF_ARP		0
+
+/* ARP Hooks */
+#define NF_ARP_IN	0
+#define NF_ARP_OUT	1
+#define NF_ARP_FORWARD	2
+
+#ifndef __KERNEL__
+#define NF_ARP_NUMHOOKS	3
+#endif
+
+#endif /* __LINUX_ARP_NETFILTER_H */
diff --git a/tools/include/uapi/linux/rtnetlink.h b/tools/include/uapi/linux/rtnetlink.h
new file mode 100644
index 000000000000..dab9493c791b
--- /dev/null
+++ b/tools/include/uapi/linux/rtnetlink.h
@@ -0,0 +1,848 @@
+/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
+#ifndef _UAPI__LINUX_RTNETLINK_H
+#define _UAPI__LINUX_RTNETLINK_H
+
+#include <linux/types.h>
+#include <linux/netlink.h>
+#include <linux/if_link.h>
+#include <linux/if_addr.h>
+#include <linux/neighbour.h>
+
+/* rtnetlink families. Values up to 127 are reserved for real address
+ * families, values above 128 may be used arbitrarily.
+ */
+#define RTNL_FAMILY_IPMR		128
+#define RTNL_FAMILY_IP6MR		129
+#define RTNL_FAMILY_MAX			129
+
+/****
+ *		Routing/neighbour discovery messages.
+ ****/
+
+/* Types of messages */
+
+enum {
+	RTM_BASE	= 16,
+#define RTM_BASE	RTM_BASE
+
+	RTM_NEWLINK	= 16,
+#define RTM_NEWLINK	RTM_NEWLINK
+	RTM_DELLINK,
+#define RTM_DELLINK	RTM_DELLINK
+	RTM_GETLINK,
+#define RTM_GETLINK	RTM_GETLINK
+	RTM_SETLINK,
+#define RTM_SETLINK	RTM_SETLINK
+
+	RTM_NEWADDR	= 20,
+#define RTM_NEWADDR	RTM_NEWADDR
+	RTM_DELADDR,
+#define RTM_DELADDR	RTM_DELADDR
+	RTM_GETADDR,
+#define RTM_GETADDR	RTM_GETADDR
+
+	RTM_NEWROUTE	= 24,
+#define RTM_NEWROUTE	RTM_NEWROUTE
+	RTM_DELROUTE,
+#define RTM_DELROUTE	RTM_DELROUTE
+	RTM_GETROUTE,
+#define RTM_GETROUTE	RTM_GETROUTE
+
+	RTM_NEWNEIGH	= 28,
+#define RTM_NEWNEIGH	RTM_NEWNEIGH
+	RTM_DELNEIGH,
+#define RTM_DELNEIGH	RTM_DELNEIGH
+	RTM_GETNEIGH,
+#define RTM_GETNEIGH	RTM_GETNEIGH
+
+	RTM_NEWRULE	= 32,
+#define RTM_NEWRULE	RTM_NEWRULE
+	RTM_DELRULE,
+#define RTM_DELRULE	RTM_DELRULE
+	RTM_GETRULE,
+#define RTM_GETRULE	RTM_GETRULE
+
+	RTM_NEWQDISC	= 36,
+#define RTM_NEWQDISC	RTM_NEWQDISC
+	RTM_DELQDISC,
+#define RTM_DELQDISC	RTM_DELQDISC
+	RTM_GETQDISC,
+#define RTM_GETQDISC	RTM_GETQDISC
+
+	RTM_NEWTCLASS	= 40,
+#define RTM_NEWTCLASS	RTM_NEWTCLASS
+	RTM_DELTCLASS,
+#define RTM_DELTCLASS	RTM_DELTCLASS
+	RTM_GETTCLASS,
+#define RTM_GETTCLASS	RTM_GETTCLASS
+
+	RTM_NEWTFILTER	= 44,
+#define RTM_NEWTFILTER	RTM_NEWTFILTER
+	RTM_DELTFILTER,
+#define RTM_DELTFILTER	RTM_DELTFILTER
+	RTM_GETTFILTER,
+#define RTM_GETTFILTER	RTM_GETTFILTER
+
+	RTM_NEWACTION	= 48,
+#define RTM_NEWACTION   RTM_NEWACTION
+	RTM_DELACTION,
+#define RTM_DELACTION   RTM_DELACTION
+	RTM_GETACTION,
+#define RTM_GETACTION   RTM_GETACTION
+
+	RTM_NEWPREFIX	= 52,
+#define RTM_NEWPREFIX	RTM_NEWPREFIX
+
+	RTM_NEWMULTICAST = 56,
+#define RTM_NEWMULTICAST RTM_NEWMULTICAST
+	RTM_DELMULTICAST,
+#define RTM_DELMULTICAST RTM_DELMULTICAST
+	RTM_GETMULTICAST,
+#define RTM_GETMULTICAST RTM_GETMULTICAST
+
+	RTM_NEWANYCAST	= 60,
+#define RTM_NEWANYCAST RTM_NEWANYCAST
+	RTM_DELANYCAST,
+#define RTM_DELANYCAST RTM_DELANYCAST
+	RTM_GETANYCAST,
+#define RTM_GETANYCAST	RTM_GETANYCAST
+
+	RTM_NEWNEIGHTBL	= 64,
+#define RTM_NEWNEIGHTBL	RTM_NEWNEIGHTBL
+	RTM_GETNEIGHTBL	= 66,
+#define RTM_GETNEIGHTBL	RTM_GETNEIGHTBL
+	RTM_SETNEIGHTBL,
+#define RTM_SETNEIGHTBL	RTM_SETNEIGHTBL
+
+	RTM_NEWNDUSEROPT = 68,
+#define RTM_NEWNDUSEROPT RTM_NEWNDUSEROPT
+
+	RTM_NEWADDRLABEL = 72,
+#define RTM_NEWADDRLABEL RTM_NEWADDRLABEL
+	RTM_DELADDRLABEL,
+#define RTM_DELADDRLABEL RTM_DELADDRLABEL
+	RTM_GETADDRLABEL,
+#define RTM_GETADDRLABEL RTM_GETADDRLABEL
+
+	RTM_GETDCB = 78,
+#define RTM_GETDCB RTM_GETDCB
+	RTM_SETDCB,
+#define RTM_SETDCB RTM_SETDCB
+
+	RTM_NEWNETCONF = 80,
+#define RTM_NEWNETCONF RTM_NEWNETCONF
+	RTM_DELNETCONF,
+#define RTM_DELNETCONF RTM_DELNETCONF
+	RTM_GETNETCONF = 82,
+#define RTM_GETNETCONF RTM_GETNETCONF
+
+	RTM_NEWMDB = 84,
+#define RTM_NEWMDB RTM_NEWMDB
+	RTM_DELMDB = 85,
+#define RTM_DELMDB RTM_DELMDB
+	RTM_GETMDB = 86,
+#define RTM_GETMDB RTM_GETMDB
+
+	RTM_NEWNSID = 88,
+#define RTM_NEWNSID RTM_NEWNSID
+	RTM_DELNSID = 89,
+#define RTM_DELNSID RTM_DELNSID
+	RTM_GETNSID = 90,
+#define RTM_GETNSID RTM_GETNSID
+
+	RTM_NEWSTATS = 92,
+#define RTM_NEWSTATS RTM_NEWSTATS
+	RTM_GETSTATS = 94,
+#define RTM_GETSTATS RTM_GETSTATS
+	RTM_SETSTATS,
+#define RTM_SETSTATS RTM_SETSTATS
+
+	RTM_NEWCACHEREPORT = 96,
+#define RTM_NEWCACHEREPORT RTM_NEWCACHEREPORT
+
+	RTM_NEWCHAIN = 100,
+#define RTM_NEWCHAIN RTM_NEWCHAIN
+	RTM_DELCHAIN,
+#define RTM_DELCHAIN RTM_DELCHAIN
+	RTM_GETCHAIN,
+#define RTM_GETCHAIN RTM_GETCHAIN
+
+	RTM_NEWNEXTHOP = 104,
+#define RTM_NEWNEXTHOP	RTM_NEWNEXTHOP
+	RTM_DELNEXTHOP,
+#define RTM_DELNEXTHOP	RTM_DELNEXTHOP
+	RTM_GETNEXTHOP,
+#define RTM_GETNEXTHOP	RTM_GETNEXTHOP
+
+	RTM_NEWLINKPROP = 108,
+#define RTM_NEWLINKPROP	RTM_NEWLINKPROP
+	RTM_DELLINKPROP,
+#define RTM_DELLINKPROP	RTM_DELLINKPROP
+	RTM_GETLINKPROP,
+#define RTM_GETLINKPROP	RTM_GETLINKPROP
+
+	RTM_NEWVLAN = 112,
+#define RTM_NEWVLAN	RTM_NEWVLAN
+	RTM_DELVLAN,
+#define RTM_DELVLAN	RTM_DELVLAN
+	RTM_GETVLAN,
+#define RTM_GETVLAN	RTM_GETVLAN
+
+	RTM_NEWNEXTHOPBUCKET = 116,
+#define RTM_NEWNEXTHOPBUCKET	RTM_NEWNEXTHOPBUCKET
+	RTM_DELNEXTHOPBUCKET,
+#define RTM_DELNEXTHOPBUCKET	RTM_DELNEXTHOPBUCKET
+	RTM_GETNEXTHOPBUCKET,
+#define RTM_GETNEXTHOPBUCKET	RTM_GETNEXTHOPBUCKET
+
+	RTM_NEWTUNNEL = 120,
+#define RTM_NEWTUNNEL	RTM_NEWTUNNEL
+	RTM_DELTUNNEL,
+#define RTM_DELTUNNEL	RTM_DELTUNNEL
+	RTM_GETTUNNEL,
+#define RTM_GETTUNNEL	RTM_GETTUNNEL
+
+	__RTM_MAX,
+#define RTM_MAX		(((__RTM_MAX + 3) & ~3) - 1)
+};
+
+#define RTM_NR_MSGTYPES	(RTM_MAX + 1 - RTM_BASE)
+#define RTM_NR_FAMILIES	(RTM_NR_MSGTYPES >> 2)
+#define RTM_FAM(cmd)	(((cmd) - RTM_BASE) >> 2)
+
+/* 
+   Generic structure for encapsulation of optional route information.
+   It is reminiscent of sockaddr, but with sa_family replaced
+   with attribute type.
+ */
+
+struct rtattr {
+	unsigned short	rta_len;
+	unsigned short	rta_type;
+};
+
+/* Macros to handle rtattributes */
+
+#define RTA_ALIGNTO	4U
+#define RTA_ALIGN(len) ( ((len)+RTA_ALIGNTO-1) & ~(RTA_ALIGNTO-1) )
+#define RTA_OK(rta,len) ((len) >= (int)sizeof(struct rtattr) && \
+			 (rta)->rta_len >= sizeof(struct rtattr) && \
+			 (rta)->rta_len <= (len))
+#define RTA_NEXT(rta,attrlen)	((attrlen) -= RTA_ALIGN((rta)->rta_len), \
+				 (struct rtattr*)(((char*)(rta)) + RTA_ALIGN((rta)->rta_len)))
+#define RTA_LENGTH(len)	(RTA_ALIGN(sizeof(struct rtattr)) + (len))
+#define RTA_SPACE(len)	RTA_ALIGN(RTA_LENGTH(len))
+#define RTA_DATA(rta)   ((void*)(((char*)(rta)) + RTA_LENGTH(0)))
+#define RTA_PAYLOAD(rta) ((int)((rta)->rta_len) - RTA_LENGTH(0))
+
+
+
+
+/******************************************************************************
+ *		Definitions used in routing table administration.
+ ****/
+
+struct rtmsg {
+	unsigned char		rtm_family;
+	unsigned char		rtm_dst_len;
+	unsigned char		rtm_src_len;
+	unsigned char		rtm_tos;
+
+	unsigned char		rtm_table;	/* Routing table id */
+	unsigned char		rtm_protocol;	/* Routing protocol; see below	*/
+	unsigned char		rtm_scope;	/* See below */	
+	unsigned char		rtm_type;	/* See below	*/
+
+	unsigned		rtm_flags;
+};
+
+/* rtm_type */
+
+enum {
+	RTN_UNSPEC,
+	RTN_UNICAST,		/* Gateway or direct route	*/
+	RTN_LOCAL,		/* Accept locally		*/
+	RTN_BROADCAST,		/* Accept locally as broadcast,
+				   send as broadcast */
+	RTN_ANYCAST,		/* Accept locally as broadcast,
+				   but send as unicast */
+	RTN_MULTICAST,		/* Multicast route		*/
+	RTN_BLACKHOLE,		/* Drop				*/
+	RTN_UNREACHABLE,	/* Destination is unreachable   */
+	RTN_PROHIBIT,		/* Administratively prohibited	*/
+	RTN_THROW,		/* Not in this table		*/
+	RTN_NAT,		/* Translate this address	*/
+	RTN_XRESOLVE,		/* Use external resolver	*/
+	__RTN_MAX
+};
+
+#define RTN_MAX (__RTN_MAX - 1)
+
+
+/* rtm_protocol */
+
+#define RTPROT_UNSPEC		0
+#define RTPROT_REDIRECT		1	/* Route installed by ICMP redirects;
+					   not used by current IPv4 */
+#define RTPROT_KERNEL		2	/* Route installed by kernel		*/
+#define RTPROT_BOOT		3	/* Route installed during boot		*/
+#define RTPROT_STATIC		4	/* Route installed by administrator	*/
+
+/* Values of protocol >= RTPROT_STATIC are not interpreted by kernel;
+   they are just passed from user and back as is.
+   It will be used by hypothetical multiple routing daemons.
+   Note that protocol values should be standardized in order to
+   avoid conflicts.
+ */
+
+#define RTPROT_GATED		8	/* Apparently, GateD */
+#define RTPROT_RA		9	/* RDISC/ND router advertisements */
+#define RTPROT_MRT		10	/* Merit MRT */
+#define RTPROT_ZEBRA		11	/* Zebra */
+#define RTPROT_BIRD		12	/* BIRD */
+#define RTPROT_DNROUTED		13	/* DECnet routing daemon */
+#define RTPROT_XORP		14	/* XORP */
+#define RTPROT_NTK		15	/* Netsukuku */
+#define RTPROT_DHCP		16	/* DHCP client */
+#define RTPROT_MROUTED		17	/* Multicast daemon */
+#define RTPROT_KEEPALIVED	18	/* Keepalived daemon */
+#define RTPROT_BABEL		42	/* Babel daemon */
+#define RTPROT_OVN		84	/* OVN daemon */
+#define RTPROT_OPENR		99	/* Open Routing (Open/R) Routes */
+#define RTPROT_BGP		186	/* BGP Routes */
+#define RTPROT_ISIS		187	/* ISIS Routes */
+#define RTPROT_OSPF		188	/* OSPF Routes */
+#define RTPROT_RIP		189	/* RIP Routes */
+#define RTPROT_EIGRP		192	/* EIGRP Routes */
+
+/* rtm_scope
+
+   Really it is not scope, but sort of distance to the destination.
+   NOWHERE are reserved for not existing destinations, HOST is our
+   local addresses, LINK are destinations, located on directly attached
+   link and UNIVERSE is everywhere in the Universe.
+
+   Intermediate values are also possible f.e. interior routes
+   could be assigned a value between UNIVERSE and LINK.
+*/
+
+enum rt_scope_t {
+	RT_SCOPE_UNIVERSE=0,
+/* User defined values  */
+	RT_SCOPE_SITE=200,
+	RT_SCOPE_LINK=253,
+	RT_SCOPE_HOST=254,
+	RT_SCOPE_NOWHERE=255
+};
+
+/* rtm_flags */
+
+#define RTM_F_NOTIFY		0x100	/* Notify user of route change	*/
+#define RTM_F_CLONED		0x200	/* This route is cloned		*/
+#define RTM_F_EQUALIZE		0x400	/* Multipath equalizer: NI	*/
+#define RTM_F_PREFIX		0x800	/* Prefix addresses		*/
+#define RTM_F_LOOKUP_TABLE	0x1000	/* set rtm_table to FIB lookup result */
+#define RTM_F_FIB_MATCH	        0x2000	/* return full fib lookup match */
+#define RTM_F_OFFLOAD		0x4000	/* route is offloaded */
+#define RTM_F_TRAP		0x8000	/* route is trapping packets */
+#define RTM_F_OFFLOAD_FAILED	0x20000000 /* route offload failed, this value
+					    * is chosen to avoid conflicts with
+					    * other flags defined in
+					    * include/uapi/linux/ipv6_route.h
+					    */
+
+/* Reserved table identifiers */
+
+enum rt_class_t {
+	RT_TABLE_UNSPEC=0,
+/* User defined values */
+	RT_TABLE_COMPAT=252,
+	RT_TABLE_DEFAULT=253,
+	RT_TABLE_MAIN=254,
+	RT_TABLE_LOCAL=255,
+	RT_TABLE_MAX=0xFFFFFFFF
+};
+
+
+/* Routing message attributes */
+
+enum rtattr_type_t {
+	RTA_UNSPEC,
+	RTA_DST,
+	RTA_SRC,
+	RTA_IIF,
+	RTA_OIF,
+	RTA_GATEWAY,
+	RTA_PRIORITY,
+	RTA_PREFSRC,
+	RTA_METRICS,
+	RTA_MULTIPATH,
+	RTA_PROTOINFO, /* no longer used */
+	RTA_FLOW,
+	RTA_CACHEINFO,
+	RTA_SESSION, /* no longer used */
+	RTA_MP_ALGO, /* no longer used */
+	RTA_TABLE,
+	RTA_MARK,
+	RTA_MFC_STATS,
+	RTA_VIA,
+	RTA_NEWDST,
+	RTA_PREF,
+	RTA_ENCAP_TYPE,
+	RTA_ENCAP,
+	RTA_EXPIRES,
+	RTA_PAD,
+	RTA_UID,
+	RTA_TTL_PROPAGATE,
+	RTA_IP_PROTO,
+	RTA_SPORT,
+	RTA_DPORT,
+	RTA_NH_ID,
+	RTA_FLOWLABEL,
+	__RTA_MAX
+};
+
+#define RTA_MAX (__RTA_MAX - 1)
+
+#define RTM_RTA(r)  ((struct rtattr*)(((char*)(r)) + NLMSG_ALIGN(sizeof(struct rtmsg))))
+#define RTM_PAYLOAD(n) NLMSG_PAYLOAD(n,sizeof(struct rtmsg))
+
+/* RTM_MULTIPATH --- array of struct rtnexthop.
+ *
+ * "struct rtnexthop" describes all necessary nexthop information,
+ * i.e. parameters of path to a destination via this nexthop.
+ *
+ * At the moment it is impossible to set different prefsrc, mtu, window
+ * and rtt for different paths from multipath.
+ */
+
+struct rtnexthop {
+	unsigned short		rtnh_len;
+	unsigned char		rtnh_flags;
+	unsigned char		rtnh_hops;
+	int			rtnh_ifindex;
+};
+
+/* rtnh_flags */
+
+#define RTNH_F_DEAD		1	/* Nexthop is dead (used by multipath)	*/
+#define RTNH_F_PERVASIVE	2	/* Do recursive gateway lookup	*/
+#define RTNH_F_ONLINK		4	/* Gateway is forced on link	*/
+#define RTNH_F_OFFLOAD		8	/* Nexthop is offloaded */
+#define RTNH_F_LINKDOWN		16	/* carrier-down on nexthop */
+#define RTNH_F_UNRESOLVED	32	/* The entry is unresolved (ipmr) */
+#define RTNH_F_TRAP		64	/* Nexthop is trapping packets */
+
+#define RTNH_COMPARE_MASK	(RTNH_F_DEAD | RTNH_F_LINKDOWN | \
+				 RTNH_F_OFFLOAD | RTNH_F_TRAP)
+
+/* Macros to handle hexthops */
+
+#define RTNH_ALIGNTO	4
+#define RTNH_ALIGN(len) ( ((len)+RTNH_ALIGNTO-1) & ~(RTNH_ALIGNTO-1) )
+#define RTNH_OK(rtnh,len) ((rtnh)->rtnh_len >= sizeof(struct rtnexthop) && \
+			   ((int)(rtnh)->rtnh_len) <= (len))
+#define RTNH_NEXT(rtnh)	((struct rtnexthop*)(((char*)(rtnh)) + RTNH_ALIGN((rtnh)->rtnh_len)))
+#define RTNH_LENGTH(len) (RTNH_ALIGN(sizeof(struct rtnexthop)) + (len))
+#define RTNH_SPACE(len)	RTNH_ALIGN(RTNH_LENGTH(len))
+#define RTNH_DATA(rtnh)   ((struct rtattr*)(((char*)(rtnh)) + RTNH_LENGTH(0)))
+
+/* RTA_VIA */
+struct rtvia {
+	__kernel_sa_family_t	rtvia_family;
+	__u8			rtvia_addr[];
+};
+
+/* RTM_CACHEINFO */
+
+struct rta_cacheinfo {
+	__u32	rta_clntref;
+	__u32	rta_lastuse;
+	__s32	rta_expires;
+	__u32	rta_error;
+	__u32	rta_used;
+
+#define RTNETLINK_HAVE_PEERINFO 1
+	__u32	rta_id;
+	__u32	rta_ts;
+	__u32	rta_tsage;
+};
+
+/* RTM_METRICS --- array of struct rtattr with types of RTAX_* */
+
+enum {
+	RTAX_UNSPEC,
+#define RTAX_UNSPEC RTAX_UNSPEC
+	RTAX_LOCK,
+#define RTAX_LOCK RTAX_LOCK
+	RTAX_MTU,
+#define RTAX_MTU RTAX_MTU
+	RTAX_WINDOW,
+#define RTAX_WINDOW RTAX_WINDOW
+	RTAX_RTT,
+#define RTAX_RTT RTAX_RTT
+	RTAX_RTTVAR,
+#define RTAX_RTTVAR RTAX_RTTVAR
+	RTAX_SSTHRESH,
+#define RTAX_SSTHRESH RTAX_SSTHRESH
+	RTAX_CWND,
+#define RTAX_CWND RTAX_CWND
+	RTAX_ADVMSS,
+#define RTAX_ADVMSS RTAX_ADVMSS
+	RTAX_REORDERING,
+#define RTAX_REORDERING RTAX_REORDERING
+	RTAX_HOPLIMIT,
+#define RTAX_HOPLIMIT RTAX_HOPLIMIT
+	RTAX_INITCWND,
+#define RTAX_INITCWND RTAX_INITCWND
+	RTAX_FEATURES,
+#define RTAX_FEATURES RTAX_FEATURES
+	RTAX_RTO_MIN,
+#define RTAX_RTO_MIN RTAX_RTO_MIN
+	RTAX_INITRWND,
+#define RTAX_INITRWND RTAX_INITRWND
+	RTAX_QUICKACK,
+#define RTAX_QUICKACK RTAX_QUICKACK
+	RTAX_CC_ALGO,
+#define RTAX_CC_ALGO RTAX_CC_ALGO
+	RTAX_FASTOPEN_NO_COOKIE,
+#define RTAX_FASTOPEN_NO_COOKIE RTAX_FASTOPEN_NO_COOKIE
+	__RTAX_MAX
+};
+
+#define RTAX_MAX (__RTAX_MAX - 1)
+
+#define RTAX_FEATURE_ECN		(1 << 0)
+#define RTAX_FEATURE_SACK		(1 << 1) /* unused */
+#define RTAX_FEATURE_TIMESTAMP		(1 << 2) /* unused */
+#define RTAX_FEATURE_ALLFRAG		(1 << 3) /* unused */
+#define RTAX_FEATURE_TCP_USEC_TS	(1 << 4)
+
+#define RTAX_FEATURE_MASK	(RTAX_FEATURE_ECN |		\
+				 RTAX_FEATURE_SACK |		\
+				 RTAX_FEATURE_TIMESTAMP |	\
+				 RTAX_FEATURE_ALLFRAG |		\
+				 RTAX_FEATURE_TCP_USEC_TS)
+
+struct rta_session {
+	__u8	proto;
+	__u8	pad1;
+	__u16	pad2;
+
+	union {
+		struct {
+			__u16	sport;
+			__u16	dport;
+		} ports;
+
+		struct {
+			__u8	type;
+			__u8	code;
+			__u16	ident;
+		} icmpt;
+
+		__u32		spi;
+	} u;
+};
+
+struct rta_mfc_stats {
+	__u64	mfcs_packets;
+	__u64	mfcs_bytes;
+	__u64	mfcs_wrong_if;
+};
+
+/****
+ *		General form of address family dependent message.
+ ****/
+
+struct rtgenmsg {
+	unsigned char		rtgen_family;
+};
+
+/*****************************************************************
+ *		Link layer specific messages.
+ ****/
+
+/* struct ifinfomsg
+ * passes link level specific information, not dependent
+ * on network protocol.
+ */
+
+struct ifinfomsg {
+	unsigned char	ifi_family;
+	unsigned char	__ifi_pad;
+	unsigned short	ifi_type;		/* ARPHRD_* */
+	int		ifi_index;		/* Link index	*/
+	unsigned	ifi_flags;		/* IFF_* flags	*/
+	unsigned	ifi_change;		/* IFF_* change mask */
+};
+
+/********************************************************************
+ *		prefix information 
+ ****/
+
+struct prefixmsg {
+	unsigned char	prefix_family;
+	unsigned char	prefix_pad1;
+	unsigned short	prefix_pad2;
+	int		prefix_ifindex;
+	unsigned char	prefix_type;
+	unsigned char	prefix_len;
+	unsigned char	prefix_flags;
+	unsigned char	prefix_pad3;
+};
+
+enum 
+{
+	PREFIX_UNSPEC,
+	PREFIX_ADDRESS,
+	PREFIX_CACHEINFO,
+	__PREFIX_MAX
+};
+
+#define PREFIX_MAX	(__PREFIX_MAX - 1)
+
+struct prefix_cacheinfo {
+	__u32	preferred_time;
+	__u32	valid_time;
+};
+
+
+/*****************************************************************
+ *		Traffic control messages.
+ ****/
+
+struct tcmsg {
+	unsigned char	tcm_family;
+	unsigned char	tcm__pad1;
+	unsigned short	tcm__pad2;
+	int		tcm_ifindex;
+	__u32		tcm_handle;
+	__u32		tcm_parent;
+/* tcm_block_index is used instead of tcm_parent
+ * in case tcm_ifindex == TCM_IFINDEX_MAGIC_BLOCK
+ */
+#define tcm_block_index tcm_parent
+	__u32		tcm_info;
+};
+
+/* For manipulation of filters in shared block, tcm_ifindex is set to
+ * TCM_IFINDEX_MAGIC_BLOCK, and tcm_parent is aliased to tcm_block_index
+ * which is the block index.
+ */
+#define TCM_IFINDEX_MAGIC_BLOCK (0xFFFFFFFFU)
+
+enum {
+	TCA_UNSPEC,
+	TCA_KIND,
+	TCA_OPTIONS,
+	TCA_STATS,
+	TCA_XSTATS,
+	TCA_RATE,
+	TCA_FCNT,
+	TCA_STATS2,
+	TCA_STAB,
+	TCA_PAD,
+	TCA_DUMP_INVISIBLE,
+	TCA_CHAIN,
+	TCA_HW_OFFLOAD,
+	TCA_INGRESS_BLOCK,
+	TCA_EGRESS_BLOCK,
+	TCA_DUMP_FLAGS,
+	TCA_EXT_WARN_MSG,
+	__TCA_MAX
+};
+
+#define TCA_MAX (__TCA_MAX - 1)
+
+#define TCA_DUMP_FLAGS_TERSE (1 << 0) /* Means that in dump user gets only basic
+				       * data necessary to identify the objects
+				       * (handle, cookie, etc.) and stats.
+				       */
+
+#define TCA_RTA(r)  ((struct rtattr*)(((char*)(r)) + NLMSG_ALIGN(sizeof(struct tcmsg))))
+#define TCA_PAYLOAD(n) NLMSG_PAYLOAD(n,sizeof(struct tcmsg))
+
+/********************************************************************
+ *		Neighbor Discovery userland options
+ ****/
+
+struct nduseroptmsg {
+	unsigned char	nduseropt_family;
+	unsigned char	nduseropt_pad1;
+	unsigned short	nduseropt_opts_len;	/* Total length of options */
+	int		nduseropt_ifindex;
+	__u8		nduseropt_icmp_type;
+	__u8		nduseropt_icmp_code;
+	unsigned short	nduseropt_pad2;
+	unsigned int	nduseropt_pad3;
+	/* Followed by one or more ND options */
+};
+
+enum {
+	NDUSEROPT_UNSPEC,
+	NDUSEROPT_SRCADDR,
+	__NDUSEROPT_MAX
+};
+
+#define NDUSEROPT_MAX	(__NDUSEROPT_MAX - 1)
+
+#ifndef __KERNEL__
+/* RTnetlink multicast groups - backwards compatibility for userspace */
+#define RTMGRP_LINK		1
+#define RTMGRP_NOTIFY		2
+#define RTMGRP_NEIGH		4
+#define RTMGRP_TC		8
+
+#define RTMGRP_IPV4_IFADDR	0x10
+#define RTMGRP_IPV4_MROUTE	0x20
+#define RTMGRP_IPV4_ROUTE	0x40
+#define RTMGRP_IPV4_RULE	0x80
+
+#define RTMGRP_IPV6_IFADDR	0x100
+#define RTMGRP_IPV6_MROUTE	0x200
+#define RTMGRP_IPV6_ROUTE	0x400
+#define RTMGRP_IPV6_IFINFO	0x800
+
+#define RTMGRP_DECnet_IFADDR    0x1000
+#define RTMGRP_DECnet_ROUTE     0x4000
+
+#define RTMGRP_IPV6_PREFIX	0x20000
+#endif
+
+/* RTnetlink multicast groups */
+enum rtnetlink_groups {
+	RTNLGRP_NONE,
+#define RTNLGRP_NONE		RTNLGRP_NONE
+	RTNLGRP_LINK,
+#define RTNLGRP_LINK		RTNLGRP_LINK
+	RTNLGRP_NOTIFY,
+#define RTNLGRP_NOTIFY		RTNLGRP_NOTIFY
+	RTNLGRP_NEIGH,
+#define RTNLGRP_NEIGH		RTNLGRP_NEIGH
+	RTNLGRP_TC,
+#define RTNLGRP_TC		RTNLGRP_TC
+	RTNLGRP_IPV4_IFADDR,
+#define RTNLGRP_IPV4_IFADDR	RTNLGRP_IPV4_IFADDR
+	RTNLGRP_IPV4_MROUTE,
+#define	RTNLGRP_IPV4_MROUTE	RTNLGRP_IPV4_MROUTE
+	RTNLGRP_IPV4_ROUTE,
+#define RTNLGRP_IPV4_ROUTE	RTNLGRP_IPV4_ROUTE
+	RTNLGRP_IPV4_RULE,
+#define RTNLGRP_IPV4_RULE	RTNLGRP_IPV4_RULE
+	RTNLGRP_IPV6_IFADDR,
+#define RTNLGRP_IPV6_IFADDR	RTNLGRP_IPV6_IFADDR
+	RTNLGRP_IPV6_MROUTE,
+#define RTNLGRP_IPV6_MROUTE	RTNLGRP_IPV6_MROUTE
+	RTNLGRP_IPV6_ROUTE,
+#define RTNLGRP_IPV6_ROUTE	RTNLGRP_IPV6_ROUTE
+	RTNLGRP_IPV6_IFINFO,
+#define RTNLGRP_IPV6_IFINFO	RTNLGRP_IPV6_IFINFO
+	RTNLGRP_DECnet_IFADDR,
+#define RTNLGRP_DECnet_IFADDR	RTNLGRP_DECnet_IFADDR
+	RTNLGRP_NOP2,
+	RTNLGRP_DECnet_ROUTE,
+#define RTNLGRP_DECnet_ROUTE	RTNLGRP_DECnet_ROUTE
+	RTNLGRP_DECnet_RULE,
+#define RTNLGRP_DECnet_RULE	RTNLGRP_DECnet_RULE
+	RTNLGRP_NOP4,
+	RTNLGRP_IPV6_PREFIX,
+#define RTNLGRP_IPV6_PREFIX	RTNLGRP_IPV6_PREFIX
+	RTNLGRP_IPV6_RULE,
+#define RTNLGRP_IPV6_RULE	RTNLGRP_IPV6_RULE
+	RTNLGRP_ND_USEROPT,
+#define RTNLGRP_ND_USEROPT	RTNLGRP_ND_USEROPT
+	RTNLGRP_PHONET_IFADDR,
+#define RTNLGRP_PHONET_IFADDR	RTNLGRP_PHONET_IFADDR
+	RTNLGRP_PHONET_ROUTE,
+#define RTNLGRP_PHONET_ROUTE	RTNLGRP_PHONET_ROUTE
+	RTNLGRP_DCB,
+#define RTNLGRP_DCB		RTNLGRP_DCB
+	RTNLGRP_IPV4_NETCONF,
+#define RTNLGRP_IPV4_NETCONF	RTNLGRP_IPV4_NETCONF
+	RTNLGRP_IPV6_NETCONF,
+#define RTNLGRP_IPV6_NETCONF	RTNLGRP_IPV6_NETCONF
+	RTNLGRP_MDB,
+#define RTNLGRP_MDB		RTNLGRP_MDB
+	RTNLGRP_MPLS_ROUTE,
+#define RTNLGRP_MPLS_ROUTE	RTNLGRP_MPLS_ROUTE
+	RTNLGRP_NSID,
+#define RTNLGRP_NSID		RTNLGRP_NSID
+	RTNLGRP_MPLS_NETCONF,
+#define RTNLGRP_MPLS_NETCONF	RTNLGRP_MPLS_NETCONF
+	RTNLGRP_IPV4_MROUTE_R,
+#define RTNLGRP_IPV4_MROUTE_R	RTNLGRP_IPV4_MROUTE_R
+	RTNLGRP_IPV6_MROUTE_R,
+#define RTNLGRP_IPV6_MROUTE_R	RTNLGRP_IPV6_MROUTE_R
+	RTNLGRP_NEXTHOP,
+#define RTNLGRP_NEXTHOP		RTNLGRP_NEXTHOP
+	RTNLGRP_BRVLAN,
+#define RTNLGRP_BRVLAN		RTNLGRP_BRVLAN
+	RTNLGRP_MCTP_IFADDR,
+#define RTNLGRP_MCTP_IFADDR	RTNLGRP_MCTP_IFADDR
+	RTNLGRP_TUNNEL,
+#define RTNLGRP_TUNNEL		RTNLGRP_TUNNEL
+	RTNLGRP_STATS,
+#define RTNLGRP_STATS		RTNLGRP_STATS
+	RTNLGRP_IPV4_MCADDR,
+#define RTNLGRP_IPV4_MCADDR	RTNLGRP_IPV4_MCADDR
+	RTNLGRP_IPV6_MCADDR,
+#define RTNLGRP_IPV6_MCADDR	RTNLGRP_IPV6_MCADDR
+	RTNLGRP_IPV6_ACADDR,
+#define RTNLGRP_IPV6_ACADDR	RTNLGRP_IPV6_ACADDR
+	__RTNLGRP_MAX
+};
+#define RTNLGRP_MAX	(__RTNLGRP_MAX - 1)
+
+/* TC action piece */
+struct tcamsg {
+	unsigned char	tca_family;
+	unsigned char	tca__pad1;
+	unsigned short	tca__pad2;
+};
+
+enum {
+	TCA_ROOT_UNSPEC,
+	TCA_ROOT_TAB,
+#define TCA_ACT_TAB TCA_ROOT_TAB
+#define TCAA_MAX TCA_ROOT_TAB
+	TCA_ROOT_FLAGS,
+	TCA_ROOT_COUNT,
+	TCA_ROOT_TIME_DELTA, /* in msecs */
+	TCA_ROOT_EXT_WARN_MSG,
+	__TCA_ROOT_MAX,
+#define	TCA_ROOT_MAX (__TCA_ROOT_MAX - 1)
+};
+
+#define TA_RTA(r)  ((struct rtattr*)(((char*)(r)) + NLMSG_ALIGN(sizeof(struct tcamsg))))
+#define TA_PAYLOAD(n) NLMSG_PAYLOAD(n,sizeof(struct tcamsg))
+/* tcamsg flags stored in attribute TCA_ROOT_FLAGS
+ *
+ * TCA_ACT_FLAG_LARGE_DUMP_ON user->kernel to request for larger than
+ * TCA_ACT_MAX_PRIO actions in a dump. All dump responses will contain the
+ * number of actions being dumped stored in for user app's consumption in
+ * TCA_ROOT_COUNT
+ *
+ * TCA_ACT_FLAG_TERSE_DUMP user->kernel to request terse (brief) dump that only
+ * includes essential action info (kind, index, etc.)
+ *
+ */
+#define TCA_FLAG_LARGE_DUMP_ON		(1 << 0)
+#define TCA_ACT_FLAG_LARGE_DUMP_ON	TCA_FLAG_LARGE_DUMP_ON
+#define TCA_ACT_FLAG_TERSE_DUMP		(1 << 1)
+
+/* New extended info filters for IFLA_EXT_MASK */
+#define RTEXT_FILTER_VF		(1 << 0)
+#define RTEXT_FILTER_BRVLAN	(1 << 1)
+#define RTEXT_FILTER_BRVLAN_COMPRESSED	(1 << 2)
+#define	RTEXT_FILTER_SKIP_STATS	(1 << 3)
+#define RTEXT_FILTER_MRP	(1 << 4)
+#define RTEXT_FILTER_CFM_CONFIG	(1 << 5)
+#define RTEXT_FILTER_CFM_STATUS	(1 << 6)
+#define RTEXT_FILTER_MST	(1 << 7)
+
+/* End of information exported to user level */
+
+
+
+#endif /* _UAPI__LINUX_RTNETLINK_H */
diff --git a/tools/perf/check-headers.sh b/tools/perf/check-headers.sh
index 7b515e605125..bef2b147aaaa 100755
--- a/tools/perf/check-headers.sh
+++ b/tools/perf/check-headers.sh
@@ -11,10 +11,16 @@ declare -a FILES=(
   "include/uapi/linux/bits.h"
   "include/uapi/linux/fadvise.h"
   "include/uapi/linux/fscrypt.h"
+  "include/uapi/linux/genetlink.h"
+  "include/uapi/linux/if_addr.h"
+  "include/uapi/linux/in.h"
   "include/uapi/linux/kcmp.h"
   "include/uapi/linux/kvm.h"
-  "include/uapi/linux/in.h"
+  "include/uapi/linux/neighbour.h"
+  "include/uapi/linux/netfilter.h"
+  "include/uapi/linux/netfilter_arp.h"
   "include/uapi/linux/perf_event.h"
+  "include/uapi/linux/rtnetlink.h"
   "include/uapi/linux/seccomp.h"
   "include/uapi/linux/stat.h"
   "include/linux/bits.h"
-- 
2.51.0.355.g5224444f11-goog


