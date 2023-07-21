Return-Path: <bpf+bounces-5642-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F0BF075D019
	for <lists+bpf@lfdr.de>; Fri, 21 Jul 2023 18:53:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A7142282381
	for <lists+bpf@lfdr.de>; Fri, 21 Jul 2023 16:53:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B4A027F00;
	Fri, 21 Jul 2023 16:53:37 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C90CF1F93B
	for <bpf@vger.kernel.org>; Fri, 21 Jul 2023 16:53:36 +0000 (UTC)
Received: from frasgout11.his.huawei.com (unknown [14.137.139.23])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 412901FD2;
	Fri, 21 Jul 2023 09:53:34 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.18.147.228])
	by frasgout11.his.huawei.com (SkyGuard) with ESMTP id 4R6vwh6X9Kz9xFPw;
	Sat, 22 Jul 2023 00:22:44 +0800 (CST)
Received: from huaweicloud.com (unknown [10.204.63.22])
	by APP2 (Coremail) with SMTP id GxC2BwC3hl1bs7pkcDDSBA--.22409S2;
	Fri, 21 Jul 2023 17:33:39 +0100 (CET)
From: Roberto Sassu <roberto.sassu@huaweicloud.com>
To: zohar@linux.ibm.com,
	dmitry.kasatkin@gmail.com,
	paul@paul-moore.com,
	jmorris@namei.org,
	serge@hallyn.com
Cc: linux-kernel@vger.kernel.org,
	linux-integrity@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	bpf@vger.kernel.org,
	jarkko@kernel.org,
	pbrobinson@gmail.com,
	zbyszek@in.waw.pl,
	hch@lst.de,
	mjg59@srcf.ucam.org,
	Roberto Sassu <roberto.sassu@huawei.com>
Subject: [RFC][PATCH 00/12] integrity: Introduce a digest cache
Date: Fri, 21 Jul 2023 18:33:14 +0200
Message-Id: <20230721163326.4106089-1-roberto.sassu@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:GxC2BwC3hl1bs7pkcDDSBA--.22409S2
X-Coremail-Antispam: 1UD129KBjvAXoW3uF45Gr47XFyxKFWkXr45trb_yoW8Xr1fuo
	Zaqa13Zw4DKry3CF4q9FnrZFsrWanYgw1xJrWvqrW5X3WfXFWUG3Z8Ca17XFy3Zr18Gry7
	Cw10q3yUJr4ktr93n29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
	AaLaJ3UjIYCTnIWjp_UUUYf7kC6x804xWl14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK
	8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4
	AK67xGY2AK021l84ACjcxK6xIIjxv20xvE14v26r4j6ryUM28EF7xvwVC0I7IYx2IY6xkF
	7I0E14v26r4UJVWxJr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7
	CjxVAFwI0_Gr1j6F4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAq
	x4xG6I80ewAv7VC0I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6x
	CaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxkF
	7I0En4kS14v26r4a6rW5MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI
	8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AK
	xVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r4j6ryUMIIF0xvE2Ix0cI
	8IcVCY1x0267AKxVW8Jr0_Cr1UMIIF0xvE42xK8VAvwI8IcIk0rVWrJr0_WFyUJwCI42IY
	6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv6xkF7I0E14v26r4UJVWxJrUvcSsGvfC2Kf
	nxnUUI43ZEXa7IU8imRUUUUUU==
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAQAFBF1jj5DJPgAAsW
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,MAY_BE_FORGED,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_BL,RCVD_IN_MSPIKE_L3,RDNS_DYNAMIC,
	SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Roberto Sassu <roberto.sassu@huawei.com>

A bit of history first. The original name of this work was IMA Digest
Lists, which was somehow considered too invasive. I then moved the code
to a separate component named DIGLIM (DIGest Lists Integrity Module), with
the purpose of removing the complexity away of IMA, and also add the
possibility of using it with other kernel components (e.g. Integrity Policy
Enforcement, or IPE).

Since it was originally proposed, in 2017, this work grew up a lot thanks
to the feedback of my colleagues and external reviewers. It became
integrally part of the openEuler distribution since end of 2020. The
upstreaming process has been difficult, also due to the fact too many
features were included in the proposals.

So, I decided to take a step back and find the minimum possible set of
features that would make this work meaningful. The really minimum set that
would make appraisal work is to parse the RPM header (after signature
verification) containing the reference digests and compare the calculated
file digest with them. That would be similar to reading the signature from
the xattr and verifying the digest.

But, maybe that was too minimal. It does not make sense to appraise and
parse again the same RPM header for another packaged files. And should not
be necessarily tied to appraisal, as it would be useful for measurement too
(to make a PCR predictable). Please read the Benefits section here:

https://lore.kernel.org/linux-integrity/20210914163401.864635-1-roberto.sassu@huawei.com/

So, this is how the integrity digest cache is born.

The main difference with the previous attempts is that there is not a
centralized place to store file/metadata digests, but they are stored in
the digest cache, attached to the file (the digest list) the digest cache
was created from.

The link with the files being measured/appraised is the new
security.digest_list xattr containing the full path of the digest list
they refer to. At the time there is a measurement/appraisal, the digest
cache is built by reading (after appraisal) and parsing the digest list
(a TLV format and the RPM package format are currently supported).
Extracted digests are added to a per-package hash table, sized depending on
the number of elements.

Lookup should be much faster, as we are not anymore searching in a hash
table with 80000 digests, but most of the time with 100 or less. Also,
there is no need for locking after creation, the digest cache does not
change depending on writes (it would not make sense, since digest lists are
signed). Another very important feature is that the digest cache is
reclaimable, i.e. it disappears if the inode is evicted from memory. In
that case, the digest cache need to be initialized again. The digest cache
does not disappear while IMA is using it, by acquiring and releasing a
reference to the path structure of the digest list.

What about the predictability of PCRs, that some folks are trying to
address with the Unified Kernel Image? The concept of digest lists is
quite simple: measure the digest list to represent the possible access of a
group of files, instead of recording individual file accesses. If digest
lists are measured in a deterministic way, the PCR remains predictable
despite files are accessed in a different order. We currently don't support
xattrs in the initial ram disk, but if we did and the initial ram disk uses
the same measured files as the root filesystem, the PCR would still remain
predictable.

Another important point of the design was to avoid any possible
interference with existing IMA measurement and appraisal behavior. This
has been achieved in the following way.

First, the digest cache needs to be explicitly enabled in the IMA policy
through the new policy keyword 'digest_cache=content'. Second, new-style
measurements cannot be done on the default IMA PCR, a policy writer must
specify a different PCR or the policy will be rejected. Also, the use of
the digest cache is incompatible with other appraisal methods, e.g. with
xattrs or a modsig. The policy writer cannot specify any of the other
methods if it includes the digest_cache directive. Finally, the digest
cache does not bypass EVM too. Files matched with the digest caches can
only be opened read-only, to prevent updating an unverified HMAC to a valid
one.

Another incorrect policy combination is forbidden. The use of the
digest_cache directive alone does not enable the new behavior. The action
for which the digest cache should be used should have also be done on the
digest list itself. Otherwise, one cannot explain why there are no
measurements (if the digest list was not measured for example). The same
applies for appraisal.

The last part I wanted to talk about is about the digest list parsers. This
was a long debate. In the original proposal, Matthew Garrett and Christoph
Hellwig said that adding parsers in the kernel is not scalable and not a
good idea in general. While I do agree with them, I'm also thinking what
benefits we get if we relax a bit this requirement. If we merge this patch
set and the dependency (user asymmetric keys and signatures) today, we are
immediately able to have a predictable PCR for measurement, and do
appraisal at least of executable code without additional support from the
Linux distributions. We would need a small rpm plugin to write/remove RPM
headers and their signature to/from the disk as soon as packages are
installed/removed.

Over the years, I have tried many alternatives to the kernel-based parsers.
In the very first version, we supported only one digest list format in the
kernel, and injected the digest list to each package at build time. While
it works, it is still one way to do that, others don't support it and it is
building infrastructure-dependent.

I have tried to do the conversion from the RPM format to the kernel format
in user space, with the idea that the process doing it could be isolated
against an untrusted root. I had a recent discussion with the security
folks and they don't seem excited about it.

I have fully implemented DIGLIM and PGP keys and signatures support in
eBPF. The idea itself of being able to add kernel functionality in a safe
way without touching the kernel is very nice, and I would have pursued it
more. However, after I found LSM policy bypass and other bugs and after my
patches were not accepted by the maintainers, I didn't really feel I could
rely on this subsystem. So, back to the original approach for now,
maintainers seem to be more incline to accept kernel code, if there is a
need for strong isolation. In the future, we might work on better
alternative.

This patch set depends on:

https://lore.kernel.org/linux-integrity/20230720153247.3755856-2-roberto.sassu@huaweicloud.com/

which allows to appraise RPM package headers with the PGP keys of Linux
distribution vendors.


Patch 1 introduces a new hook to identify the loading of digest lists and
consequently appraise them.

Patches 2-4 implement the digest cache, and an iterator to prefetch the
digest lists to measure them in a deterministic way.

Patches 5-6 implement the currently supported digest list formats: tlv and
rpm. The tlv format relies on the TLV parser defined in the patch set
mentioned above.

Patches 7-9 enable the usage of the digest cache in IMA for measurement and
appraisal.

Patches 10-12 add a tool to manage digest lists.

If you are curious to try on an existing system, you first need to build
gpg with the patches in the previous patch set, and convert the PGP keys of
your Linux distribution to the new user asymmetric key format:

$ gpg --conv-kernel <path of PGP key> >> certs/uasym_keys.bin

This embeds the converted keys in the kernel image. Then, enable the
following kernel options:

CONFIG_INTEGRITY_DIGEST_CACHE=y
CONFIG_UASYM_KEYS_SIGS=y
CONFIG_UASYM_PRELOAD_PUBLIC_KEYS=y

and rebuild the kernel with the patches applied. After boot, build and
install the digest list tool in tools/digest-lists, and execute:

$ manage_digest_lists -o gen -d /etc/digest_lists -i rpmdb -f rpm

You also need the new gpg when you execute this tool, to convert the PGP
signatures of the RPM headers to the user asymmetric key format.

You may want to add the following additional files in a digest list by
creating a file named 'list' with the content:

/usr/bin/manage_digest_lists
/usr/lib64/libgen-tlv-list.so
/usr/lib64/libgen-rpm-list.so
/usr/lib64/libparse-rpm-list.so
/usr/lib64/libparse-tlv-list.so

and, execute:

$ manage_digest_lists -i list -L -d /etc/digest_lists -o gen -f tlv

You need to sign the created file:

scripts/sign-file sha256 certs/signing_key.pem certs/signing_key.pem /etc/digest_lists/tlv-list

The final step is to add security.digest_list to each file with:

$ manage_digest_lists -i /etc/digest_lists -o add-xattr

After that, create the following policy in /etc/ima/ima-policy:

dont_measure fsmagic=0x01021994
dont_appraise fsmagic=0x01021994
appraise func=BPRM_CHECK digest_cache=content
appraise func=MMAP_CHECK digest_cache=content
appraise func=DIGEST_LIST_CHECK appraise_type=imasig|modsig
measure func=DIGEST_LIST_CHECK template=ima-modsig pcr=11
measure func=BPRM_CHECK digest_cache=content pcr=11
measure func=MMAP_CHECK digest_cache=content pcr=11

I'm excluding tmpfs for now, we need to deal with memfd.

Before loading the policy, you could enable the dynamic debug with:

$ echo "file tlv* +p" > /sys/kernel/debug/dynamic_debug/control
$ echo "file rpm* +p" > /sys/kernel/debug/dynamic_debug/control
$ echo "file digest* +p" > /sys/kernel/debug/dynamic_debug/control

Or add the same strings with the dyndbg= option in the kernel command line.

Then, just cat the policy to IMA:

$ cat /etc/ima/ima-policy > /sys/kernel/security/ima/policy

If that worked, you can reboot the system. Systemd will take care of
loading the IMA policy at boot. Everything works for me on Fedora 38.

You can check the content of the measurement list:

$ cat /sys/kernel/security/ima/ascii_runtime_measurements

You will see only the measurement of the digest lists, not of the other
files. If you try:

$ cp -a /bin/cat .
$ ./cat

That will work. But if you do:

$ echo 1 >> cat
$ cat
-bash: ./cat: Permission denied

Execution will be denied, and you will see a new entry in the measurement
list (honestly, it should not be there, as access to the file was denied):

11 50b5a68bea0776a84eef6725f17ce474756e51c0 ima-ng sha256:15e1efee080fe54f5d7404af7e913de01671e745ce55215d89f3d6521d3884f0 /root/cat

Finally, you could try to evict inodes from memory, to free the digest
cache:

$ echo 3 > /proc/sys/vm/drop_caches

You will see in the kernel logs messages like:

[  313.032536] DIGEST CACHE: Remove digest sha256:102900208eef27b766380135906d431dba87edaa7ec6aa72e6ebd3dd67f3a97b from digest list /etc/digest_lists/rpm-libseccomp-2.5.3-4.fc38.x86_64

Roberto Sassu (12):
  ima: Introduce hook DIGEST_LIST_CHECK
  integrity: Introduce a digest cache
  integrity/digest_cache: Add functions to populate and search
  integrity/digest_cache: Iterate over digest lists in same dir
  integrity/digest_cache: Parse tlv digest lists
  integrity/digest_cache: Parse rpm digest lists
  ima: Add digest_cache policy keyword
  ima: Use digest cache for measurement
  ima: Use digest cache for appraisal
  tools: Add tool to manage digest lists
  tools/digest-lists: Add tlv digest list generator and parser
  tools/digest-lists: Add rpm digest list generator and parser

 Documentation/ABI/testing/ima_policy          |   6 +-
 MAINTAINERS                                   |   1 +
 include/linux/kernel_read_file.h              |   1 +
 include/uapi/linux/tlv_digest_list.h          |  59 +++
 include/uapi/linux/xattr.h                    |   3 +
 security/integrity/Kconfig                    |  12 +
 security/integrity/Makefile                   |   4 +
 security/integrity/digest_cache.c             | 430 ++++++++++++++++++
 security/integrity/digest_cache.h             | 113 +++++
 security/integrity/digest_cache_iter.c        | 163 +++++++
 .../integrity/digest_list_parsers/parsers.h   |  15 +
 security/integrity/digest_list_parsers/rpm.c  | 174 +++++++
 security/integrity/digest_list_parsers/tlv.c  | 188 ++++++++
 security/integrity/iint.c                     |   7 +
 security/integrity/ima/ima.h                  |  17 +-
 security/integrity/ima/ima_api.c              |  22 +-
 security/integrity/ima/ima_appraise.c         |  16 +-
 security/integrity/ima/ima_main.c             |  39 +-
 security/integrity/ima/ima_policy.c           |  54 ++-
 security/integrity/integrity.h                |   5 +
 tools/Makefile                                |  16 +-
 tools/digest-lists/.gitignore                 |   7 +
 tools/digest-lists/Makefile                   |  72 +++
 tools/digest-lists/common.c                   | 163 +++++++
 tools/digest-lists/common.h                   |  90 ++++
 tools/digest-lists/generators/generators.h    |  18 +
 tools/digest-lists/generators/rpm.c           | 257 +++++++++++
 tools/digest-lists/generators/tlv.c           | 168 +++++++
 tools/digest-lists/manage_digest_lists.c      | 349 ++++++++++++++
 tools/digest-lists/manage_digest_lists.txt    |  82 ++++
 tools/digest-lists/parsers/parsers.h          |  16 +
 tools/digest-lists/parsers/rpm.c              | 169 +++++++
 tools/digest-lists/parsers/tlv.c              | 195 ++++++++
 tools/digest-lists/parsers/tlv_parser.h       |  38 ++
 34 files changed, 2942 insertions(+), 27 deletions(-)
 create mode 100644 include/uapi/linux/tlv_digest_list.h
 create mode 100644 security/integrity/digest_cache.c
 create mode 100644 security/integrity/digest_cache.h
 create mode 100644 security/integrity/digest_cache_iter.c
 create mode 100644 security/integrity/digest_list_parsers/parsers.h
 create mode 100644 security/integrity/digest_list_parsers/rpm.c
 create mode 100644 security/integrity/digest_list_parsers/tlv.c
 create mode 100644 tools/digest-lists/.gitignore
 create mode 100644 tools/digest-lists/Makefile
 create mode 100644 tools/digest-lists/common.c
 create mode 100644 tools/digest-lists/common.h
 create mode 100644 tools/digest-lists/generators/generators.h
 create mode 100644 tools/digest-lists/generators/rpm.c
 create mode 100644 tools/digest-lists/generators/tlv.c
 create mode 100644 tools/digest-lists/manage_digest_lists.c
 create mode 100644 tools/digest-lists/manage_digest_lists.txt
 create mode 100644 tools/digest-lists/parsers/parsers.h
 create mode 100644 tools/digest-lists/parsers/rpm.c
 create mode 100644 tools/digest-lists/parsers/tlv.c
 create mode 100644 tools/digest-lists/parsers/tlv_parser.h

-- 
2.34.1


