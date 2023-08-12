Return-Path: <bpf+bounces-7660-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CE5F779F79
	for <lists+bpf@lfdr.de>; Sat, 12 Aug 2023 13:07:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 20DB1280FDE
	for <lists+bpf@lfdr.de>; Sat, 12 Aug 2023 11:07:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 309931FD1;
	Sat, 12 Aug 2023 11:07:11 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6D211868
	for <bpf@vger.kernel.org>; Sat, 12 Aug 2023 11:07:10 +0000 (UTC)
Received: from frasgout13.his.huawei.com (unknown [14.137.139.46])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F6B1AF;
	Sat, 12 Aug 2023 04:07:07 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.18.147.228])
	by frasgout13.his.huawei.com (SkyGuard) with ESMTP id 4RNHDh6w4SzB03Lj;
	Sat, 12 Aug 2023 18:37:56 +0800 (CST)
Received: from huaweicloud.com (unknown [10.204.63.22])
	by APP1 (Coremail) with SMTP id LxC2BwBXC7scY9dkThi9AA--.8440S15;
	Sat, 12 Aug 2023 11:49:09 +0100 (CET)
From: Roberto Sassu <roberto.sassu@huaweicloud.com>
To: corbet@lwn.net,
	zohar@linux.ibm.com,
	dmitry.kasatkin@gmail.com,
	paul@paul-moore.com,
	jmorris@namei.org,
	serge@hallyn.com
Cc: linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-integrity@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	bpf@vger.kernel.org,
	jarkko@kernel.org,
	pbrobinson@gmail.com,
	zbyszek@in.waw.pl,
	hch@lst.de,
	mjg59@srcf.ucam.org,
	pmatilai@redhat.com,
	jannh@google.com,
	Roberto Sassu <roberto.sassu@huawei.com>
Subject: [RFC][PATCH v2 13/13] docs: Add documentation of the integrity digest cache
Date: Sat, 12 Aug 2023 12:46:16 +0200
Message-Id: <20230812104616.2190095-14-roberto.sassu@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230812104616.2190095-1-roberto.sassu@huaweicloud.com>
References: <20230812104616.2190095-1-roberto.sassu@huaweicloud.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:LxC2BwBXC7scY9dkThi9AA--.8440S15
X-Coremail-Antispam: 1UD129KBjvAXoWfGr1fWrWxtF4DtFyDtFW3trb_yoW8ZrWkJo
	ZIvw45Cw45Kry5uF4UCFnrJF47G3ZYgwn7AF48tr45WF1aqF45Ka1DC3WUWFW5Jr4rGa4x
	A348Jw4xJF1ktrn3n29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
	AaLaJ3UjIYCTnIWjp_UUUYu7kC6x804xWl14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK
	8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JF
	0E3s1l82xGYIkIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vE
	j48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxV
	AFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26r4j6F4UM28EF7xvwVC2z280aVCY1x02
	67AKxVWxJr0_GcWle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrV
	C2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE
	7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwACI402YVCY1x02628vn2kIc2xKxwCF04k20x
	vY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I
	3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_GFv_WrylIxkGc2Ij64vIr41lIx
	AIcVC0I7IYx2IY67AKxVW8JVW5JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJwCI
	42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z2
	80aVCY1x0267AKxVWxJr0_GcJvcSsGvfC2KfnxnUUI43ZEXa7IU13l1DUUUUU==
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAgAHBF1jj46UtAABsf
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,MAY_BE_FORGED,
	PDS_RDNS_DYNAMIC_FP,RCVD_IN_DNSWL_BLOCKED,RDNS_DYNAMIC,SPF_HELO_NONE,
	SPF_NONE,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Roberto Sassu <roberto.sassu@huawei.com>

Add the documentation of the integrity digest cache in
Documentation/security.

Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
---
 Documentation/security/index.rst              |   1 +
 .../security/integrity-digest-cache.rst       | 484 ++++++++++++++++++
 MAINTAINERS                                   |   1 +
 3 files changed, 486 insertions(+)
 create mode 100644 Documentation/security/integrity-digest-cache.rst

diff --git a/Documentation/security/index.rst b/Documentation/security/index.rst
index 6ed8d2fa6f9..3316d50c839 100644
--- a/Documentation/security/index.rst
+++ b/Documentation/security/index.rst
@@ -18,3 +18,4 @@ Security Documentation
    digsig
    landlock
    secrets/index
+   integrity-digest-cache
diff --git a/Documentation/security/integrity-digest-cache.rst b/Documentation/security/integrity-digest-cache.rst
new file mode 100644
index 00000000000..371b3f84780
--- /dev/null
+++ b/Documentation/security/integrity-digest-cache.rst
@@ -0,0 +1,484 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+======================
+Integrity Digest Cache
+======================
+
+Introduction
+============
+
+The main goal of Integrity Measurement Architecture (IMA) is to perform a
+measurement of the file content and use it for remote attestation, to
+report a possibly compromised system, using the TPM as a root of trust. It
+can also prevent a system compromise from happening by checking the
+calculated file digest against a known-good reference value and by denying
+the current operation if there is a mismatch.
+
+
+Motivation
+==========
+
+This patch set aims to address two important shortcomings: predictability
+of the Platform Configuration Registers (PCRs), and the provisioning of
+reference values to compare the calculated file digest against.
+
+Remote attestation, according to Trusted Computing Group (TCG)
+specifications, is done by replicating the PCR extend operation in
+software with the digests in the event log (in this case the IMA
+measurement list), and by comparing the obtained value with the PCR value
+signed by the TPM with the quote operation.
+
+Due to how the extend operation is performed, if measurements are done in
+a different order, the final PCR value will be different. That means that
+if measurements are done in parallel, there is no way to predict what the
+final PCR value will be, making impossible to seal data to a PCR value. If
+the PCR value was predictable, a system could for example prove its
+integrity by unsealing and using its private key, without sending every
+time the full list of measurements.
+
+Provisioning reference values for file digests is also a difficult task.
+The solution so far was to add file signatures to RPM packages, and
+possibly to DEB packages, so that IMA can verify them. While this undoubtly
+works, it also requires Linux distribution vendors to support the feature
+by rebuilding all their packages, and eventually extending their PKI to
+perform the additional signatures. It could also require developers extra
+work to deal with the additional data.
+
+On the other hand, since often packages carry the file digests themselves,
+it won't be actually needed to add file signatures. If the kernel was able
+to extract the file digests by itself, all the tasks mentioned above for
+the Linux distribution vendors won't be needed too. All current and past
+Linux distributions can be easily retrofitted to enable IMA appraisal with
+the file digests from the packages.
+
+Narrowing down the scope of a package parser to only extract specific
+information makes it small enough to accurately verify that it cannot harm
+the kernel. An additional mitigation consists in verifying the signature of
+the package first, before attempting to extract the file digests.
+
+
+Solution
+========
+
+To avoid a PCR is extended in a non-deterministic way, the proposed
+solution is to replace individual file measurements with the measurement of
+a file (the digest list) containing a set of file digests. If the
+calculated digest of a file being measured/appraised matches one digest in
+the set, its measurement is skipped. If otherwise there is no match, the
+file digest is added to the measurement list.
+
+The resulting measurement list, which cannot be done on the default IMA PCR
+to avoid ambiguity with the default-style measurement, has the following
+meaning: none/some/all files represented with the measurement of the digest
+lists COULD have been accessed, without knowing IF and WHEN. Any other
+measurement (other than boot_aggregate) is of a file whose digest was not
+included in the digest list.
+
+File signatures have a coarser granularity, it is per-signing key and not
+per-package. A measurement list containing just the measurement of the
+signing keys and the files without/invalid signature (those with valid
+signature would be skipped) would be even less accurate.
+
+To ensure a rapid and smooth deployment of IMA appraisal, the kernel has
+been provided with the ability to extract file digests from the RPM
+package headers, and add them to the kernel memory on demand (only when a
+file from a given package is accessed). This ensures that the memory
+consumption for this new feature is directly proportional to the usage of
+the system.
+
+
+Scope
+=====
+
+The integrity digest cache enables IMA to extend a PCR (not the default
+one) in a deterministic fashion, and to appraise immutable files with file
+digests from the packages, when no other appraisal method is available. It
+does not yet support metadata verification with Extended Verification
+Module (EVM), for which a separate patch set will be provided.
+
+
+Design
+======
+
+The digest cache is a hash table of file digests, attached to the inode of
+the digest list from which file digests are extracted. It is accessible,
+when a given file is being measured/appraised, from the new xattr
+security.digest_list, containing the path of the digest list itself.
+
+If the calculated file digest is found in the digest cache, its measurement
+is avoided, or read-only access is granted if appraisal is in enforcing
+mode. Read-write access is prevented to avoid updating an unverified HMAC
+of file metadata.
+
+The digest cache can be used only if the following conditions are met:
+
+- The ``digest_cache=content`` keyword is added to the desired IMA policy
+  rules;
+- If the rule action is ``measure``, a PCR different from the default one
+  is specified;
+- If the rule action is ``appraise``, ``digest_cache=content`` and
+  ``appraise_type`` don't appear at the same time;
+- The same action for which the digest cache is used was done also on the
+  digest list;
+- The digest cache (currently) is not used for measurement/appraisal of
+  other digest lists.
+
+For performance reasons, the digest cache is attached to every inode using
+it, since multiple hooks can be invoked on it before the
+measurement/appraisal result is cached. A reference count indicates how
+many inodes use it, and only when it reaches zero, the digest cache can be
+freed (for example when inodes are evicted from memory).
+
+Two digest cache pointers have been added to the iint to distinguish for
+which purpose they should be used: dig_owner points to the digest cache
+created from the same inode the iint refers to, and should be used for
+measurement/appraisal of other inodes; dig_user points to the digest
+cache created from a different inode, and requested for
+measurement/appraisal. One digest cache pointer would be confusing, as
+for digest lists the digest cache was created from them, but IMA would
+try to use that digest cache for measurement/appraisal of itself.
+
+Finally, at the first digest list measurement, an iterator is executed to
+sequentially read (not parse) all the digest lists in the same directory,
+so that the PCR is extended in a deterministic fashion. The other
+concurrent users of the digest cache have to wait until the iterator
+finishes.
+
+
+API
+===
+
+Data Structures
+~~~~~~~~~~~~~~~
+
+.. kernel-doc:: security/integrity/digest_cache.h
+
+
+Functions
+~~~~~~~~~
+
+.. kernel-doc:: security/integrity/digest_cache.c
+
+``digest_cache_alloc()``, ``digest_cache_parse_digest_list()`` and
+``digest_cache_new()`` are internal functions used during the creation and
+initialization of the digest cache.
+
+``digest_cache_get()`` and ``digest_cache_free()`` are called by the user
+of the digest cache (e.g. IMA), to obtain and free a digest cache.
+
+``digest_cache_init_htable()``, ``digest_cache_add()`` and
+``digest_cache_lookup()`` are called by the digest list parsers to populate
+and search in a digest cache.
+
+
+Digest List Formats
+===================
+
+tlv
+~~~
+
+The Type-Length-Value (TLV) format was chosen for its extensibility.
+Additional fields can be added without breaking compatibility with old
+versions of the parser.
+
+The layout of a tlv digest list is the following::
+
+ [header: DIGEST_LIST_FILE, num fields, total len]
+ [field: DIGEST_LIST_ALGO, length, value]
+ [field: DIGEST_LIST_ENTRY#1, length, value (below)]
+  |- [header: DIGEST_LIST_FILE, num fields, total len]
+  |- [ENTRY#1_DIGEST, length, file digest]
+  |- [ENTRY#1_PATH, length, file path]
+ [field: DIGEST_LIST_ENTRY#N, length, value (below)]
+  |- [header: DIGEST_LIST_FILE, num fields, total len]
+  |- [ENTRY#N_DIGEST, length, file digest]
+  |- [ENTRY#N_PATH, length, file path]
+
+DIGEST_LIST_ALGO is a field to specify the algorithm of the file digest.
+DIGEST_LIST_ENTRY is a nested TLV structure with the following fields:
+ENTRY_DIGEST contains the file digest; ENTRY_PATH contains the file path.
+
+
+rpm
+~~~
+
+The rpm digest list is basically a subset of the RPM package header.
+Its format is::
+
+ [RPM magic number]
+ [RPMTAG_IMMUTABLE]
+
+RPMTAG_IMMUTABLE is a section of the full RPM header containing the part
+of the header that was signed, and whose signature is stored in the
+RPMTAG_RSAHEADER section.
+
+
+Appended Signature
+~~~~~~~~~~~~~~~~~~
+
+Digest lists can have a module-style appended signature, that can be used
+for appraisal with IMA. The signature type can be PKCS#7, as for kernel
+modules, or the new user asymmetric key signature.
+
+
+History
+=======
+
+The original name of this work was IMA Digest Lists, which was somehow
+considered too invasive. The code was moved to a separate component named
+DIGLIM (DIGest Lists Integrity Module), with the purpose of removing the
+complexity away of IMA, and also add the possibility of using it with other
+kernel components (e.g. Integrity Policy Enforcement, or IPE).
+
+Since it was originally proposed, in 2017, this work grew up a lot thanks
+to various comments/suggestions. It became integrally part of the openEuler
+distribution since end of 2020.
+
+There are significant differences between this and the previous versions.
+The most important one is moving from a centralized repository of file
+digests to a per-package repository. This significantly reduces the memory
+pressure, since digest lists are loaded into kernel memory only when they
+are actually needed. Also, file digests are automatically unloaded from
+kernel memory at the same time inodes are evicted from memory during
+reclamation.
+
+
+Performance
+===========
+
+The tests have been performed on a Fedora 38 virtual machine, with 8 cores
+(AMD EPYC-Rome), 4GB of RAM, TPM passthrough. The signing key is an ECDSA
+NIST P-384.
+
+IMA measurement policy: no cache
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+.. code-block:: bash
+
+ dont_measure fsmagic=0x01021994
+ measure func=BPRM_CHECK
+ measure func=MMAP_CHECK
+
+
+IMA measurement policy: cache
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+.. code-block:: bash
+
+ dont_measure fsmagic=0x01021994
+ measure func=DIGEST_LIST_CHECK template=ima-modsig pcr=11
+ measure func=BPRM_CHECK digest_cache=content pcr=11
+ measure func=MMAP_CHECK digest_cache=content pcr=11
+
+
+IMA Measurement Results
+~~~~~~~~~~~~~~~~~~~~~~~
+
+::
+
+                               +-----------+-----------+-----------+
+                               | # measur. | boot time |   slab    |
+ +-----------------------------+-----------+-----------+-----------+
+ | measure (no cache)          |    389    |  12.682s  | 231453 KB |
+ +-----------------------------+-----------+-----------+-----------+
+ | measure (cache, no iter)    |    175    |  12.283s  | 234224 KB |
+ +-----------------------------+-----------+-----------+-----------+
+ | measure (cache, iter)       |    853    |  16.430s  | 238491 KB |
+ +-----------------------------+-----------+-----------+-----------+
+
+With the iterator enabled, all 852 packages are measured. Consequently, the
+boot time is longer. One possible optimization would be to exclude the
+packages that don't include measured files. By disabling the iterator, it
+can be seen that the packages actually used are 174 (one measurement is for
+boot_aggregate).
+
+
+IMA appraisal policy: no cache
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+.. code-block:: bash
+
+ dont_appraise fsmagic=0x01021994
+ appraise func=BPRM_CHECK appraise_type=imasig
+ appraise func=MMAP_CHECK appraise_type=imasig
+
+
+IMA appraisal policy: cache
+~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+.. code-block:: bash
+
+ dont_appraise fsmagic=0x01021994
+ appraise func=DIGEST_LIST_CHECK appraise_type=imasig|modsig
+ appraise func=BPRM_CHECK digest_cache=content
+ appraise func=MMAP_CHECK digest_cache=content
+
+
+IMA Appraisal Results
+~~~~~~~~~~~~~~~~~~~~~
+
+::
+
+                               +-----------+-----------+
+                               | boot time |   slab    |
+ +-----------------------------+-----------+-----------+
+ | appraise (no cache)         |  11.995s  | 231145 KB |
+ +-----------------------------+-----------+-----------+
+ | appraise (cache)            |  11.879s  | 233091 KB |
+ +-----------------------------+-----------+-----------+
+
+In this test, it can be seen that the performance of the two solutions are
+comparable, with the digest cache slightly ahead. The difference could be
+more substantial with more file appraised.
+
+
+How to Test
+===========
+
+First, it is necessary to copy the new kernel headers (tlv_parser.h,
+uasym_parser.h, tlv_digest_list.h) from usr/include/linux in the kernel
+source directory to /usr/include/linux.
+
+Then, gpg must be rebuilt with the additional patches to convert the PGP
+keys of the Linux distribution to the new user asymmetric key format:
+
+.. code-block:: bash
+
+ $ gpg --conv-kernel <path of PGP key> >> certs/uasym_keys.bin
+
+This embeds the converted keys in the kernel image. Then, the following
+kernel options must be enabled:
+
+.. code-block:: bash
+
+ CONFIG_INTEGRITY_DIGEST_CACHE=y
+ CONFIG_UASYM_KEYS_SIGS=y
+ CONFIG_UASYM_PRELOAD_PUBLIC_KEYS=y
+
+and the kernel must be rebuilt with the patches applied. After boot, it is
+necessary to build and install the digest list tool in tools/digest-lists,
+and to execute (as root):
+
+.. code-block:: bash
+
+ # manage_digest_lists -o gen -d /etc/digest_lists -i rpmdb -f rpm
+
+The new gpg must also be installed in the system, as it will be used to
+convert the PGP signatures of the RPM headers to the user asymmetric key
+format.
+
+It is recommended to create an additional digest list with the following
+files, by creating a file named ``list`` with the content:
+
+.. code-block:: bash
+
+ /usr/bin/manage_digest_lists
+ /usr/lib64/libgen-tlv-list.so
+ /usr/lib64/libgen-rpm-list.so
+ /usr/lib64/libparse-rpm-list.so
+ /usr/lib64/libparse-tlv-list.so
+
+Then, to create the digest list, it is sufficient to execute:
+
+.. code-block:: bash
+
+ # manage_digest_lists -i list -L -d /etc/digest_lists -o gen -f tlv
+
+If appraisal is enabled and in enforcing mode, it is necessary to sign the
+new digest list, with the sign-file tool in the scripts/ directory of the
+kernel sources:
+
+.. code-block:: bash
+
+ # scripts/sign-file sha256 certs/signing_key.pem certs/signing_key.pem /etc/digest_lists/tlv-list
+
+The final step is to add security.digest_list to each file with:
+
+.. code-block:: bash
+
+ # manage_digest_lists -i /etc/digest_lists -o add-xattr
+
+After that, it is possible to test the integrity digest cache with the
+following policy written to /etc/ima/ima-policy:
+
+.. code-block:: bash
+
+ dont_measure fsmagic=0x01021994
+ measure func=DIGEST_LIST_CHECK template=ima-modsig pcr=11
+ measure func=BPRM_CHECK digest_cache=content pcr=11
+ measure func=MMAP_CHECK digest_cache=content pcr=11
+ dont_appraise fsmagic=0x01021994
+ appraise func=BPRM_CHECK digest_cache=content
+ appraise func=MMAP_CHECK digest_cache=content
+ appraise func=DIGEST_LIST_CHECK appraise_type=imasig|modsig
+
+Tmpfs is excluded for now, until memfd is properly handled.
+
+Before loading the policy, it is possible to enable dynamic debug to see
+which operations are done by the integrity digest cache:
+
+.. code-block:: bash
+
+ # echo "file tlv* +p" > /sys/kernel/debug/dynamic_debug/control
+ # echo "file rpm* +p" > /sys/kernel/debug/dynamic_debug/control
+ # echo "file digest* +p" > /sys/kernel/debug/dynamic_debug/control
+
+Alternatively, the same strings can be set as value of the dyndbg= option
+in the kernel command line.
+
+A preliminary test, before booting the system with the new policy, is to
+supply the policy to IMA in the current system with:
+
+.. code-block:: bash
+
+ # cat /etc/ima/ima-policy > /sys/kernel/security/ima/policy
+
+If that worked, the system can be rebooted. Systemd will take care of
+loading the IMA policy at boot. The instructions have been tested on a
+Fedora 38 OS.
+
+After boot, it is possible to check the content of the measurement list:
+
+.. code-block:: bash
+
+ # cat /sys/kernel/security/ima/ascii_runtime_measurements
+
+If only the files shipped with Fedora 38 have been executed, the
+measurement list will contain only the digest lists, and not the individual
+files.
+
+Another test is to ensure that IMA prevents the execution of unknown files:
+
+.. code-block:: bash
+
+ # cp -a /bin/cat .
+ # ./cat
+
+That will work. But not on the modified binary:
+
+.. code-block:: bash
+
+ # echo 1 >> cat
+ # cat
+ -bash: ./cat: Permission denied
+
+Execution will be denied, and a new entry in the measurement list will
+appear (it would be probably ok to not add that entry, as access to the
+file was denied):
+
+.. code-block:: bash
+
+ 11 50b5a68bea0776a84eef6725f17ce474756e51c0 ima-ng sha256:15e1efee080fe54f5d7404af7e913de01671e745ce55215d89f3d6521d3884f0 /root/cat
+
+Finally, it is possible to test the shrinking of the digest cache, by
+forcing the kernel to evict inodes from memory:
+
+.. code-block:: bash
+
+ # echo 3 > /proc/sys/vm/drop_caches
+
+The kernel log should have messages like:
+
+.. code-block:: bash
+
+ [  313.032536] DIGEST CACHE: Remove digest sha256:102900208eef27b766380135906d431dba87edaa7ec6aa72e6ebd3dd67f3a97b from digest list /etc/digest_lists/rpm-libseccomp-2.5.3-4.fc38.x86_64
diff --git a/MAINTAINERS b/MAINTAINERS
index 2bd85dcfd23..af33db344ce 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -10293,6 +10293,7 @@ M:	Dmitry Kasatkin <dmitry.kasatkin@gmail.com>
 L:	linux-integrity@vger.kernel.org
 S:	Supported
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/zohar/linux-integrity.git
+F:	Documentation/security/integrity-digest-cache.rst
 F:	security/integrity/
 F:	security/integrity/ima/
 F:	tools/digest-lists/
-- 
2.34.1


