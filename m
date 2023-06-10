Return-Path: <bpf+bounces-2311-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ED1F872AA13
	for <lists+bpf@lfdr.de>; Sat, 10 Jun 2023 09:58:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2AD61281A63
	for <lists+bpf@lfdr.de>; Sat, 10 Jun 2023 07:58:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 298DCBA42;
	Sat, 10 Jun 2023 07:58:39 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6E516FCD
	for <bpf@vger.kernel.org>; Sat, 10 Jun 2023 07:58:38 +0000 (UTC)
Received: from frasgout11.his.huawei.com (unknown [14.137.139.23])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E9C8CC;
	Sat, 10 Jun 2023 00:58:32 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.18.147.227])
	by frasgout11.his.huawei.com (SkyGuard) with ESMTP id 4QdVRh1HlQz9xqpT;
	Sat, 10 Jun 2023 15:48:00 +0800 (CST)
Received: from huaweicloud.com (unknown [10.204.63.22])
	by APP1 (Coremail) with SMTP id LxC2BwBH0AsGLYRklC8oAw--.4566S2;
	Sat, 10 Jun 2023 08:58:08 +0100 (CET)
From: Roberto Sassu <roberto.sassu@huaweicloud.com>
To: zohar@linux.ibm.com,
	dmitry.kasatkin@gmail.com,
	paul@paul-moore.com,
	jmorris@namei.org,
	serge@hallyn.com,
	stephen.smalley.work@gmail.com,
	eparis@parisplace.org,
	casey@schaufler-ca.com
Cc: linux-kernel@vger.kernel.org,
	linux-integrity@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	selinux@vger.kernel.org,
	bpf@vger.kernel.org,
	kpsingh@kernel.org,
	keescook@chromium.org,
	nicolas.bouchinet@clip-os.org,
	Roberto Sassu <roberto.sassu@huawei.com>
Subject: [PATCH v12 0/4] evm: Do HMAC of multiple per LSM xattrs for new inodes
Date: Sat, 10 Jun 2023 09:57:34 +0200
Message-Id: <20230610075738.3273764-1-roberto.sassu@huaweicloud.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:LxC2BwBH0AsGLYRklC8oAw--.4566S2
X-Coremail-Antispam: 1UD129KBjvAXoW3ur48CFyUKrW8Ar1DZr13urg_yoW8JFWkAo
	WrXwsrXayjqF1fAw4ruFn7AFWku3yrWr4Fyr4S9r15J3W2qr4UCw15ua15XFsxWryFgr1I
	93srAF1UXFWjq3Z8n29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
	AaLaJ3UjIYCTnIWjp_UUUY87kC6x804xWl14x267AKxVW5JVWrJwAFc2x0x2IEx4CE42xK
	8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4
	AK67xGY2AK021l84ACjcxK6xIIjxv20xvE14v26r1j6r1xM28EF7xvwVC0I7IYx2IY6xkF
	7I0E14v26r4j6F4UM28EF7xvwVC2z280aVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv6xkF7I
	0E14v26r4j6r4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxAIw28I
	cxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2
	IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVW8ZVWrXwCIc40Y0x0EwIxGrwCI
	42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42
	IY6xAIw20EY4v20xvaj40_Wr1j6rW3Jr1lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2
	z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU13rcDUUUUU==
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAQAEBF1jj45+YgAAsi
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,KHOP_HELO_FCRDNS,
	MAY_BE_FORGED,PDS_RDNS_DYNAMIC_FP,RDNS_DYNAMIC,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Roberto Sassu <roberto.sassu@huawei.com>

One of the major goals of LSM stacking is to run multiple LSMs side by side
without interfering with each other. The ultimate decision will depend on
individual LSM decision.

Several changes need to be made to the LSM infrastructure to be able to
support that. This patch set tackles one of them: gives to each LSM the
ability to specify one or multiple xattrs to be set at inode creation
time and, at the same time, gives to EVM the ability to access all those
xattrs and calculate the HMAC on them.

The first problem that this patch set addresses is to make the
inode_init_security hook definition suitable to use with EVM which, unlike
other LSMs, needs to have visibility of all xattrs and not only the one
that the LSM infrastructure passes to the LSM to be set.

The solution is to replace in the inode_init_security definition the
name/value/len parameters with the beginning of the array containing all
xattrs set by LSMs. Due to security_old_inode_init_security() API
limitation of setting only one xattr, it has been dropped and the remaining
users, ocfs2 and reiserfs, switch to security_inode_init_security().
However, due to the complexity of the changes required to fully exploit the
ability of security_inode_init_security() to set multiple xattrs, those
users can still set only one xattr (the first set in the xattr array) where
previously they called security_old_inode_init_security().

Furthermore, while EVM is invoked unlike before, its xattr will not be set
as it would not be the first set in the xattr array, or if it is the first,
there would not be protected xattrs to calculate the HMAC on.

The second problem this patch set addresses is the limitation of the
call_int_hook() of stopping the loop when the return value from a hook
implementation is not zero. Unfortunately, for the inode_init_security hook
it is a legitimate case to return -EOPNOTSUPP, but this would not
necessarily mean that there is an error to report to the LSM infrastructure
but just that an LSM does not will to set an xattr. Other LSMs should be
still consulted as well.

The solution for this specific case is to replace the call_int_hook() with
the loop itself, so that -EOPNOTSUPP can be ignored. In addition, the
default return value of inode_init_security was changed to -EOPNOTSUPP, so
that BPF LSM follows the return value convention.

Next, this patch set removes the limitation of creating only two xattrs,
one by an active LSM and another by EVM. This patch set extends the
reservation mechanism of the LSM infrastructure, to allow each LSM to
request one or multiple xattrs. While this could potentially lead to
reaching the filesystem limits of number/size of the xattrs, it seems not
an issue that need to be solved by the LSM infrastructure but by the
filesystems themselves. Currently, if the limit is reached, the only
workaround would be to use fewer LSMs.

The reservation mechanism concept would have made it very easy for LSMs to
position themselves correctly in the xattr array, as the LSM infrastructure
at initialization time changes the number of xattrs requested by each LSM
with an offset.

However, this opens for the possibility of having gaps in the xattr array,
due to the fact that an LSM can request xattr slots to the LSM
infrastructure but not fill them (if it was loaded but not initialized).

Instead, the decision was to add an additional parameter to the
inode_init_security_hook, the number of filled slots in the xattr array,
which each LSM is expected to update for each xattr it provides. In this
way, the next LSM starts to fill after the last filled slot, regardless of
whether previous LSMs were initialized or not. SELinux, Smack and EVM have
been updated to use this new mechanism.

Finally, this patch set modifies the evm_inode_init_security() definition
to be compatible with the inode_init_security hook definition and adds
support for scanning the whole xattr array and for calculating the HMAC
on all xattrs provided by LSMs.

This patch set has been tested by introducing several instances of a
TestLSM (some providing an xattr, some not, one providing multiple xattrs
and another providing an xattr but in a disabled state). The patch is not
included in this set but it is available here:

https://github.com/robertosassu/linux/commit/011adfbfa30f61c80c900db9a78f4f51b5463a4a

The test, added to ima-evm-utils, is available here:

https://github.com/robertosassu/ima-evm-utils/blob/evm-multiple-lsms-v11-devel-v8/tests/evm_multiple_lsms.test

The test takes a UML kernel built by Github Actions and launches it several
times, each time with a different combination of LSMs and filesystems (ext4,
reiserfs, ocfs2). After boot, it first checks that there is an xattr for each
LSM providing it (for reiserfs and ocfs2 just the first LSM), and then (for
ext4) calculates the HMAC in user space and compares it with the HMAC
calculated by EVM in kernel space.

A test report can be obtained here (the Tumbleweed failure is unrelated):

https://github.com/robertosassu/ima-evm-utils/actions/runs/5164716489/jobs/9304130400

Another test, added to ima-evm-utils, is:

https://github.com/robertosassu/ima-evm-utils/blob/evm-multiple-lsms-v11-devel-v8/tests/evm_hmac.test

Other than doing a simple check, by comparing the EVM HMAC obtained from
ima-evm-utils and from the kernel, it also checks that the EVM HMAC is
still valid after a successful directory transmuting with Smack. If EVM
checked the HMAC of directories, it would have found an invalid HMAC
without patch 2 applied.

The patch set has been tested with both the SElinux and Smack test suites.
Below, there is the summary of the test results:

SELinux Test Suite result (without patches):
All tests successful.
Files=76, Tests=1357, 224 wallclock secs ( 0.42 usr  0.13 sys + 11.96 cusr 15.02 csys = 27.53 CPU)
Result: PASS

All tests successful.
Files=76, Tests=1357, 224 wallclock secs ( 0.40 usr  0.12 sys + 11.86 cusr 14.71 csys = 27.09 CPU)
Result: PASS

Smack Test Suite result (without patches):
95 Passed, 0 Failed, 100% Success rate

Smack Test Suite result (with patches):
95 Passed, 0 Failed, 100% Success rate

Changelog

v11 (quickly tested, only stylistic issues):
- Fix stylistic issues reported by checkpatch.pl --strict (suggested by
  Mimi)
- Avoid pointer math in lsm_get_xattr_slot() (suggested by Paul)

v10:
- Remove check for -EOPNOTSUPP by evm_inode_init_security() in
  security_inode_init_security() (suggested by Mimi)
- Adjust formatting of Smack xattrs description (suggested by Paul)
- Change value of SMACK_INODE_INIT_XATTRS from 4 to 2 (suggested by Paul)
- Add patch to set SMACK64TRANSMUTE in smack_inode_init_security()
- Replace new_xattrs + count with &new_xattrs[xattr_count] in patch 1
  (suggested by Paul)

v9:
- Ensure in reiserfs_security_write() that the full xattr name is not
  larger than XATTR_NAME_MAX
- Rename num_filled_xattrs to xattr_count everywhere (suggested by Paul)
- Rename lsm_find_xattr_slot() to lsm_get_xattr_slot() and add a proper
  documentation (suggested by Paul)
- Return zero instead of -EOPNOTSUPP in evm_inode_init_security()
  (suggested by Paul)
- Remove additional checks of new_xattrs array in
  security_inode_init_security() (suggested by Paul)
- Handle the !initxattrs case similarly to the initxattrs case, except for
  not allocating the new_xattrs array in the former (suggested by Paul)
- Remove local variable xattr in security_inode_init_security(), and use
  xattr_count instead for loop termination (suggested by Paul)

v8:
- Add a new reiserfs patch to write the full xattr name
- Add num_filled_xattrs parameter to inode_init_security hook (suggested by
  Paul) and evm_inode_init_security()
- Change default return value of inode_init_security hook to -EOPNOTSUPP
- Rename lbs_xattr field of lsm_blob_sizes to lbs_xattr_count
- Introduce lsm_find_xattr_slot() helper
- Rename lsm_xattr parameter of evm_init_hmac() to xattrs
- Retrieve the EVM xattr slot with lsm_find_xattr_slot() and double check
  with the xattr array terminator
- Remove security_check_compact_filled_xattrs() (suggested by Paul)
- Update security_inode_init_security() documentation
- Ensure that inode_init_security hook incremented the number of filled
  slots if it returned zero
- Ensure that xattr name and value are non-NULL in the filled slots
- Add the xattr name assignment after the xattr value one (suggested by
  Paul)
- Drop patches 1 - 3 (already in lsm/next)

v7:
- Add a patch dependency comment in patch 1 (suggested by Mimi)
- Restore check of -EOPNOTSUPP status in ocfs2_mknod() and ocfs2_symlink()
  (reported by Mimi)
- Add explanation in evm_inode_init_security() why walking through the
  xattrs array is safe (suggested by Mimi)
- Document the lbs_xattr field of struct lsm_blob_sizes (suggested by
  Casey)
- Move documentation changes of the inode_init_security hook to security.c,
  after LSM documentation reorganization by Paul
- Use attributes in plural form in the description of the xattrs parameter
  of smack_inode_init_security()
- Check xattr name instead of xattr value in evm_inode_init_security(),
  for consistency with evm_init_hmac(); equivalent, since
  security_check_compact_filled_xattrs() rejects xattrs with xattr name
  NULL and value not NULL, and viceversa

v6:
- Add a comment in Smack to introduce its xattrs (suggested by Casey)
- Document the overloaded meaning of -EOPNOTSUPP in
  security_inode_init_security() (suggested by Mimi)

v5:
- Modify the cover letter to explain that the goal of this patch set is
  supporting multiple per LSM xattrs in EVM, and not moving IMA and EVM to
  the LSM infrastructure (suggested by Mimi)
- Remove references in the patches description about moving IMA and EVM
  to the LSM infrastructure (suggested by Mimi)
- Explain that the additional EVM invocation due to the switch to
  security_inode_init_security() will not cause the EVM xattr to be added
  (suggested by Mimi)

v4:
- Remove patch to call reiserfs_security_free(), already queued
- Switch ocfs2 and reiserfs to security_inode_init_security() (suggested by
  Mimi)
- Remove security_old_inode_init_security() (suggested by Paul)
- Rename security_check_compact_xattrs() to
  security_check_compact_filled_xattrs() and add function description
  (suggested by Mimi)
- Rename checked_xattrs parameter of security_check_compact_filled_xattrs()
  to num_filled_xattrs (suggested by Mimi)
- Rename cur_xattrs variable in security_inode_init_security() to
  num_filled_xattrs (suggested by Mimi)

v3:
- Don't free the xattr name in reiserfs_security_free()
- Don't include fs_data parameter in inode_init_security hook
- Don't change evm_inode_init_security(), as it will be removed if EVM is
  stacked
- Fix inode_init_security hook documentation
- Drop lsm_find_xattr_slot(), use simple xattr reservation mechanism and
  introduce security_check_compact_xattrs() to compact the xattr array
- Don't allocate xattr array if LSMs didn't reserve any xattr
- Return zero if initxattrs() is not provided to
  security_inode_init_security(), -EOPNOTSUPP if value is not provided to
  security_old_inode_init_security()
- Request LSMs to fill xattrs if only value (not the triple) is provided to
  security_old_inode_init_security(), to avoid unnecessary memory
  allocation

v2:
- rewrite selinux_old_inode_init_security() to use
  security_inode_init_security()
- add lbs_xattr field to lsm_blob_sizes structure, to give the ability to
  LSMs to reserve slots in the xattr array (suggested by Casey)
- add new parameter base_slot to inode_init_security hook definition

v1:
- add calls to reiserfs_security_free() and initialize sec->value to NULL
  (suggested by Tetsuo and Mimi)
- change definition of inode_init_security hook, replace the name, value
  and len triple with the xattr array (suggested by Casey)
- introduce lsm_find_xattr_slot() helper for LSMs to find an unused slot in
  the passed xattr array

Roberto Sassu (4):
  security: Allow all LSMs to provide xattrs for inode_init_security
    hook
  smack: Set the SMACK64TRANSMUTE xattr in smack_inode_init_security()
  evm: Align evm_inode_init_security() definition with LSM
    infrastructure
  evm: Support multiple LSMs providing an xattr

 include/linux/evm.h                 | 14 +++---
 include/linux/lsm_hook_defs.h       |  6 +--
 include/linux/lsm_hooks.h           | 20 ++++++++
 security/integrity/evm/evm.h        |  4 +-
 security/integrity/evm/evm_crypto.c | 11 ++++-
 security/integrity/evm/evm_main.c   | 39 +++++++++++++---
 security/security.c                 | 71 +++++++++++++++++++----------
 security/selinux/hooks.c            | 17 +++----
 security/smack/smack.h              |  2 +-
 security/smack/smack_lsm.c          | 68 +++++++++++++++------------
 10 files changed, 172 insertions(+), 80 deletions(-)

-- 
2.25.1


