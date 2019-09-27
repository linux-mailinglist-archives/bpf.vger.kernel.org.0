Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E91A1C07F9
	for <lists+bpf@lfdr.de>; Fri, 27 Sep 2019 16:51:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727207AbfI0OuY (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 27 Sep 2019 10:50:24 -0400
Received: from 13.mo4.mail-out.ovh.net ([178.33.251.8]:44980 "EHLO
        13.mo4.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727154AbfI0OuX (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 27 Sep 2019 10:50:23 -0400
X-Greylist: delayed 1175 seconds by postgrey-1.27 at vger.kernel.org; Fri, 27 Sep 2019 10:50:20 EDT
Received: from player687.ha.ovh.net (unknown [10.109.143.183])
        by mo4.mail-out.ovh.net (Postfix) with ESMTP id 8CCD3206D4E
        for <bpf@vger.kernel.org>; Fri, 27 Sep 2019 16:30:43 +0200 (CEST)
Received: from sk2.org (unknown [65.39.69.237])
        (Authenticated sender: steve@sk2.org)
        by player687.ha.ovh.net (Postfix) with ESMTPSA id 7A2E5A476CBE;
        Fri, 27 Sep 2019 14:30:32 +0000 (UTC)
From:   Stephen Kitt <steve@sk2.org>
To:     linux-doc@vger.kernel.org
Cc:     corbet@lwn.net, bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-remoteproc@vger.kernel.org, linux-can@vger.kernel.org,
        linux-afs@lists.infradead.org, kvm@vger.kernel.org,
        Stephen Kitt <steve@sk2.org>,
        "Gustavo A . R . Silva" <gustavo@embeddedor.com>
Subject: [PATCH] docs: use flexible array members, not zero-length
Date:   Fri, 27 Sep 2019 16:29:27 +0200
Message-Id: <20190927142927.27968-1-steve@sk2.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Ovh-Tracer-Id: 2095018254973357452
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedufedrfeeigdejiecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Update the docs throughout to remove zero-length arrays, replacing
them with C99 flexible array members. GCC will then ensure that the
arrays are always the last element in the struct.

Signed-off-by: Stephen Kitt <steve@sk2.org>
Cc: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 Documentation/bpf/btf.rst                     |  2 +-
 Documentation/digsig.txt                      |  4 ++--
 Documentation/driver-api/connector.rst        |  2 +-
 Documentation/driver-api/usb/URB.rst          |  2 +-
 .../filesystems/autofs-mount-control.txt      |  2 +-
 Documentation/filesystems/autofs.txt          |  2 +-
 Documentation/filesystems/fiemap.txt          |  2 +-
 Documentation/hwspinlock.txt                  |  2 +-
 Documentation/networking/can.rst              |  2 +-
 Documentation/networking/rxrpc.txt            |  2 +-
 Documentation/remoteproc.txt                  |  4 ++--
 Documentation/virt/kvm/api.txt                | 24 +++++++++----------
 Documentation/x86/boot.rst                    |  4 ++--
 13 files changed, 27 insertions(+), 27 deletions(-)

diff --git a/Documentation/bpf/btf.rst b/Documentation/bpf/btf.rst
index 4d565d202ce3..24ce50fc1fc1 100644
--- a/Documentation/bpf/btf.rst
+++ b/Documentation/bpf/btf.rst
@@ -670,7 +670,7 @@ func_info for each specific ELF section.::
         __u32   sec_name_off; /* offset to section name */
         __u32   num_info;
         /* Followed by num_info * record_size number of bytes */
-        __u8    data[0];
+        __u8    data[];
      };
 
 Here, num_info must be greater than 0.
diff --git a/Documentation/digsig.txt b/Documentation/digsig.txt
index f6a8902d3ef7..d7479f98a27e 100644
--- a/Documentation/digsig.txt
+++ b/Documentation/digsig.txt
@@ -31,7 +31,7 @@ Public key and signature consist of header and MPIs::
 		time_t		timestamp;	/* key made, always 0 for now */
 		uint8_t		algo;
 		uint8_t		nmpi;
-		char		mpi[0];
+		char		mpi[];
 	} __packed;
 
 	struct signature_hdr {
@@ -41,7 +41,7 @@ Public key and signature consist of header and MPIs::
 		uint8_t		hash;
 		uint8_t		keyid[8];
 		uint8_t		nmpi;
-		char		mpi[0];
+		char		mpi[];
 	} __packed;
 
 keyid equals to SHA1[12-19] over the total key content.
diff --git a/Documentation/driver-api/connector.rst b/Documentation/driver-api/connector.rst
index c100c7482289..1f187028c7e1 100644
--- a/Documentation/driver-api/connector.rst
+++ b/Documentation/driver-api/connector.rst
@@ -49,7 +49,7 @@ be dereferenced to `struct cn_msg *`::
 	__u32			ack;
 
 	__u32			len;	/* Length of the following data */
-	__u8			data[0];
+	__u8			data[];
   };
 
 Connector interfaces
diff --git a/Documentation/driver-api/usb/URB.rst b/Documentation/driver-api/usb/URB.rst
index 61a54da9fce9..8aca9c39e9a0 100644
--- a/Documentation/driver-api/usb/URB.rst
+++ b/Documentation/driver-api/usb/URB.rst
@@ -82,7 +82,7 @@ Some of the fields in struct :c:type:`urb` are::
 
     // ISO only: packets are only "best effort"; each can have errors
 	int error_count;                // number of errors
-	struct usb_iso_packet_descriptor iso_frame_desc[0];
+	struct usb_iso_packet_descriptor iso_frame_desc[];
   };
 
 Your driver must create the "pipe" value using values from the appropriate
diff --git a/Documentation/filesystems/autofs-mount-control.txt b/Documentation/filesystems/autofs-mount-control.txt
index acc02fc57993..1c5cf1ecd90d 100644
--- a/Documentation/filesystems/autofs-mount-control.txt
+++ b/Documentation/filesystems/autofs-mount-control.txt
@@ -194,7 +194,7 @@ struct autofs_dev_ioctl {
 		struct args_ismountpoint	ismountpoint;
 	};
 
-	char path[0];
+	char path[];
 };
 
 The ioctlfd field is a mount point file descriptor of an autofs mount
diff --git a/Documentation/filesystems/autofs.txt b/Documentation/filesystems/autofs.txt
index 3af38c7fd26d..0766089b81f1 100644
--- a/Documentation/filesystems/autofs.txt
+++ b/Documentation/filesystems/autofs.txt
@@ -455,7 +455,7 @@ Each ioctl is passed a pointer to an `autofs_dev_ioctl` structure:
 			struct args_ismountpoint	ismountpoint;
 		};
 
-                char path[0];
+                char path[];
         };
 
 For the **OPEN_MOUNT** and **IS_MOUNTPOINT** commands, the target
diff --git a/Documentation/filesystems/fiemap.txt b/Documentation/filesystems/fiemap.txt
index f6d9c99103a4..172c94377fb3 100644
--- a/Documentation/filesystems/fiemap.txt
+++ b/Documentation/filesystems/fiemap.txt
@@ -22,7 +22,7 @@ struct fiemap {
 				    * mapped (out) */
 	__u32	fm_extent_count; /* size of fm_extents array (in) */
 	__u32	fm_reserved;
-	struct fiemap_extent fm_extents[0]; /* array of mapped extents (out) */
+	struct fiemap_extent fm_extents[]; /* array of mapped extents (out) */
 };
 
 
diff --git a/Documentation/hwspinlock.txt b/Documentation/hwspinlock.txt
index 6f03713b7003..a37e7c24ff26 100644
--- a/Documentation/hwspinlock.txt
+++ b/Documentation/hwspinlock.txt
@@ -439,7 +439,7 @@ implementation using the hwspin_lock_register() API.
 		const struct hwspinlock_ops *ops;
 		int base_id;
 		int num_locks;
-		struct hwspinlock lock[0];
+		struct hwspinlock lock[];
 	};
 
 struct hwspinlock_device contains an array of hwspinlock structs, each
diff --git a/Documentation/networking/can.rst b/Documentation/networking/can.rst
index 2fd0b51a8c52..ceb40a9d2044 100644
--- a/Documentation/networking/can.rst
+++ b/Documentation/networking/can.rst
@@ -705,7 +705,7 @@ The broadcast manager sends responses to user space in the same form:
             struct timeval ival1, ival2;    /* count and subsequent interval */
             canid_t can_id;                 /* unique can_id for task */
             __u32 nframes;                  /* number of can_frames following */
-            struct can_frame frames[0];
+            struct can_frame frames[];
     };
 
 The aligned payload 'frames' uses the same basic CAN frame structure defined
diff --git a/Documentation/networking/rxrpc.txt b/Documentation/networking/rxrpc.txt
index 180e07d956a7..b1fff6870c1b 100644
--- a/Documentation/networking/rxrpc.txt
+++ b/Documentation/networking/rxrpc.txt
@@ -518,7 +518,7 @@ form:
 		uint8_t		kvno;		/* key version number */
 		uint8_t		__pad[3];
 		uint8_t		session_key[8];	/* DES session key */
-		uint8_t		ticket[0];	/* the encrypted ticket */
+		uint8_t		ticket[];	/* the encrypted ticket */
 	};
 
 Where the ticket blob is just appended to the above structure.
diff --git a/Documentation/remoteproc.txt b/Documentation/remoteproc.txt
index 03c3d2e568b0..77b1493759b2 100644
--- a/Documentation/remoteproc.txt
+++ b/Documentation/remoteproc.txt
@@ -274,7 +274,7 @@ The resource table begins with this header::
 	u32 ver;
 	u32 num;
 	u32 reserved[2];
-	u32 offset[0];
+	u32 offset[];
   } __packed;
 
 Immediately following this header are the resource entries themselves,
@@ -291,7 +291,7 @@ each of which begins with the following resource entry header::
    */
   struct fw_rsc_hdr {
 	u32 type;
-	u8 data[0];
+	u8 data[];
   } __packed;
 
 Some resources entries are mere announcements, where the host is informed
diff --git a/Documentation/virt/kvm/api.txt b/Documentation/virt/kvm/api.txt
index 136f1eef3712..0b8955152362 100644
--- a/Documentation/virt/kvm/api.txt
+++ b/Documentation/virt/kvm/api.txt
@@ -192,7 +192,7 @@ Errors:
 
 struct kvm_msr_list {
 	__u32 nmsrs; /* number of msrs in entries */
-	__u32 indices[0];
+	__u32 indices[];
 };
 
 The user fills in the size of the indices array in nmsrs, and in return
@@ -566,7 +566,7 @@ struct kvm_msrs {
 	__u32 nmsrs; /* number of msrs in entries */
 	__u32 pad;
 
-	struct kvm_msr_entry entries[0];
+	struct kvm_msr_entry entries[];
 };
 
 struct kvm_msr_entry {
@@ -626,7 +626,7 @@ struct kvm_cpuid_entry {
 struct kvm_cpuid {
 	__u32 nent;
 	__u32 padding;
-	struct kvm_cpuid_entry entries[0];
+	struct kvm_cpuid_entry entries[];
 };
 
 
@@ -649,7 +649,7 @@ signal mask.
 /* for KVM_SET_SIGNAL_MASK */
 struct kvm_signal_mask {
 	__u32 len;
-	__u8  sigset[0];
+	__u8  sigset[];
 };
 
 
@@ -1403,7 +1403,7 @@ Returns: 0 on success, -1 on error
 struct kvm_cpuid2 {
 	__u32 nent;
 	__u32 padding;
-	struct kvm_cpuid_entry2 entries[0];
+	struct kvm_cpuid_entry2 entries[];
 };
 
 #define KVM_CPUID_FLAG_SIGNIFCANT_INDEX		BIT(0)
@@ -1516,7 +1516,7 @@ On arm/arm64, GSI routing has the following limitation:
 struct kvm_irq_routing {
 	__u32 nr;
 	__u32 flags;
-	struct kvm_irq_routing_entry entries[0];
+	struct kvm_irq_routing_entry entries[];
 };
 
 No flags are specified so far, the corresponding field must be set to zero.
@@ -2868,7 +2868,7 @@ Errors:
 
 struct kvm_reg_list {
 	__u64 n; /* number of registers in reg[] */
-	__u64 reg[0];
+	__u64 reg[];
 };
 
 This ioctl returns the guest registers that are supported for the
@@ -2997,7 +2997,7 @@ Returns: 0 on success, -1 on error
 struct kvm_cpuid2 {
 	__u32 nent;
 	__u32 flags;
-	struct kvm_cpuid_entry2 entries[0];
+	struct kvm_cpuid_entry2 entries[];
 };
 
 The member 'flags' is used for passing flags from userspace.
@@ -3889,8 +3889,8 @@ struct kvm_nested_state {
 	} hdr;
 
 	union {
-		struct kvm_vmx_nested_state_data vmx[0];
-		struct kvm_svm_nested_state_data svm[0];
+		struct kvm_vmx_nested_state_data vmx[];
+		struct kvm_svm_nested_state_data svm[];
 	} data;
 };
 
@@ -4016,7 +4016,7 @@ Returns: 0 on success, -1 on error
 struct kvm_cpuid2 {
 	__u32 nent;
 	__u32 padding;
-	struct kvm_cpuid_entry2 entries[0];
+	struct kvm_cpuid_entry2 entries[];
 };
 
 struct kvm_cpuid_entry2 {
@@ -4110,7 +4110,7 @@ struct kvm_pmu_event_filter {
 	__u32 fixed_counter_bitmap;
 	__u32 flags;
 	__u32 pad[4];
-	__u64 events[0];
+	__u64 events[];
 };
 
 This ioctl restricts the set of PMU events that the guest can program.
diff --git a/Documentation/x86/boot.rst b/Documentation/x86/boot.rst
index 08a2f100c0e6..1110c1a7337b 100644
--- a/Documentation/x86/boot.rst
+++ b/Documentation/x86/boot.rst
@@ -790,13 +790,13 @@ Protocol:	2.09+
   The 64-bit physical pointer to NULL terminated single linked list of
   struct setup_data. This is used to define a more extensible boot
   parameters passing mechanism. The definition of struct setup_data is
-  as follow::
+  as follows::
 
 	struct setup_data {
 		u64 next;
 		u32 type;
 		u32 len;
-		u8  data[0];
+		u8  data[];
 	};
 
   Where, the next is a 64-bit physical pointer to the next node of
-- 
2.20.1

