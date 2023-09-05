Return-Path: <bpf+bounces-9257-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4531C792410
	for <lists+bpf@lfdr.de>; Tue,  5 Sep 2023 17:47:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EF41628130D
	for <lists+bpf@lfdr.de>; Tue,  5 Sep 2023 15:47:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEEB8D537;
	Tue,  5 Sep 2023 15:47:20 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60B8B2571
	for <bpf@vger.kernel.org>; Tue,  5 Sep 2023 15:47:20 +0000 (UTC)
Received: from frasgout13.his.huawei.com (unknown [14.137.139.46])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3CCA194;
	Tue,  5 Sep 2023 08:47:16 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.18.147.227])
	by frasgout13.his.huawei.com (SkyGuard) with ESMTP id 4Rg8hW3bSPz9xyN0;
	Tue,  5 Sep 2023 23:35:07 +0800 (CST)
Received: from [127.0.0.1] (unknown [10.204.63.22])
	by APP1 (Coremail) with SMTP id LxC2BwC3ablUTfdkkiEwAg--.11395S2;
	Tue, 05 Sep 2023 16:46:44 +0100 (CET)
Message-ID: <3649004b908c9c79494020f37108bc70de3b2785.camel@huaweicloud.com>
Subject: Re: [RFC][PATCH v2 00/13] integrity: Introduce a digest cache
From: Roberto Sassu <roberto.sassu@huaweicloud.com>
To: corbet@lwn.net, zohar@linux.ibm.com, dmitry.kasatkin@gmail.com, 
	paul@paul-moore.com, jmorris@namei.org, serge@hallyn.com
Cc: linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
 linux-integrity@vger.kernel.org, linux-security-module@vger.kernel.org, 
 bpf@vger.kernel.org, jarkko@kernel.org, pbrobinson@gmail.com,
 zbyszek@in.waw.pl,  hch@lst.de, mjg59@srcf.ucam.org, pmatilai@redhat.com,
 jannh@google.com, Roberto Sassu <roberto.sassu@huawei.com>, pvorel@suse.cz,
 jikos@kernel.org
Date: Tue, 05 Sep 2023 17:46:25 +0200
In-Reply-To: <20230812104616.2190095-1-roberto.sassu@huaweicloud.com>
References: <20230812104616.2190095-1-roberto.sassu@huaweicloud.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-CM-TRANSID:LxC2BwC3ablUTfdkkiEwAg--.11395S2
X-Coremail-Antispam: 1UD129KBjvAXoWfuryrXw4UJF4kJr1xAFWDArb_yoW5GFWxXo
	Zava13Cw45Kry5uF4DCFn7JF47W3ZYgwn7Ar4ktrs8WF17XFW5Ga1DCa1UGFW5Xr4rGasr
	Aw18Jw47JF4ktrn3n29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
	AaLaJ3UjIYCTnIWjp_UUUYU7kC6x804xWl14x267AKxVW5JVWrJwAFc2x0x2IEx4CE42xK
	8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4
	AK67xGY2AK021l84ACjcxK6xIIjxv20xvE14v26r1j6r1xM28EF7xvwVC0I7IYx2IY6xkF
	7I0E14v26r4j6F4UM28EF7xvwVC2z280aVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv6xkF7I
	0E14v26r4j6r4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxAIw28IcxkI
	7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxV
	Cjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVW8ZVWrXwCIc40Y0x0EwIxGrwCI42IY
	6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6x
	AIw20EY4v20xvaj40_WFyUJVCq3wCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv
	6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUFDGOUUUUU
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAgALBF1jj4+ObAABsQ
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,
	RCVD_IN_DNSWL_BLOCKED,RDNS_DYNAMIC,SPF_HELO_NONE,SPF_NONE autolearn=no
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Sat, 2023-08-12 at 12:46 +0200, Roberto Sassu wrote:
> From: Roberto Sassu <roberto.sassu@huawei.com>
>=20
> Introduction
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>=20
> The main goal of Integrity Measurement Architecture (IMA) is to perform a
> measurement of the file content and use it for remote attestation, to
> report a possibly compromised system, using the TPM as a root of trust. I=
t
> can also prevent a system compromise from happening by checking the
> calculated file digest against a known-good reference value and by denyin=
g
> the current operation if there is a mismatch.

Small update, I build openSUSE Tumbleweed packages with the patches I
sent (I added an rpm plugin). After the following steps, openSUSE
Tumbleweed will:

- Provide a predictable measurement list and PCR (11)
- Enforce an IMA Appraisal policy for executable code (excluding tmpfs)
- Support the above after package installation and removal


1) Add the following repository to YaST:

https://download.opensuse.org/repositories/home:/roberto.sassu:/integrity-d=
igest-cache/standard/


2) Install the necessary packages (in a testing VM):

# zypper in gpg2-2.3.8-316.2.x86_64 kernel-kvmsmall kernel-tools-digest-lis=
ts


3) Generate the initial set of digest lists from installed packages:

# manage_digest_lists -d /etc/digest_lists -o gen -i rpmdb -f rpm


4) Add security.digest_list xattr to every file, to point to the
respective digest list:

# manage_digest_lists -i /etc/digest_lists -o add-xattr


5) Create /etc/ima/ima-policy with the content:

dont_measure fsmagic=3D0x01021994
measure func=3DDIGEST_LIST_CHECK template=3Dima-modsig pcr=3D11
measure func=3DBPRM_CHECK digest_cache=3Dcontent pcr=3D11
measure func=3DMMAP_CHECK digest_cache=3Dcontent pcr=3D11
dont_appraise fsmagic=3D0x01021994
appraise func=3DBPRM_CHECK digest_cache=3Dcontent
appraise func=3DMMAP_CHECK digest_cache=3Dcontent
appraise func=3DDIGEST_LIST_CHECK appraise_type=3Dimasig|modsig


6) Add the following lines to /etc/apparmor.d/abstractions/base, to
   allow all processes to read /etc/digest_lists

@{etc_ro}/digest_lists/**      r,


7) Reboot


That's it. Only openSUSE-distributed files are allowed to run (plus the
ones I built). If there is any problem, please reboot with
ima_appraise=3Dlog in the kernel command line, and delete the IMA policy.

I hope to receive more reviews, and to make the necessary changes to
have this new feature accepted in the kernel. This is a requirement for
Linux distributions to pick the feature up.

Thanks

Roberto

> Motivation
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>=20
> This patch set aims to address two important shortcomings: predictability
> of the Platform Configuration Registers (PCRs), and the provisioning of
> reference values to compare the calculated file digest against.
>=20
> Remote attestation, according to Trusted Computing Group (TCG)
> specifications, is done by replicating the PCR extend operation in
> software with the digests in the event log (in this case the IMA
> measurement list), and by comparing the obtained value with the PCR value
> signed by the TPM with the quote operation.
>=20
> Due to how the extend operation is performed, if measurements are done in
> a different order, the final PCR value will be different. That means that
> if measurements are done in parallel, there is no way to predict what the
> final PCR value will be, making impossible to seal data to a PCR value. I=
f
> the PCR value was predictable, a system could for example prove its
> integrity by unsealing and using its private key, without sending every
> time the full list of measurements.
>=20
> Provisioning reference values for file digests is also a difficult task.
> The solution so far was to add file signatures to RPM packages, and
> possibly to DEB packages, so that IMA can verify them. While this undoubt=
ly
> works, it also requires Linux distribution vendors to support the feature
> by rebuilding all their packages, and eventually extending their PKI to
> perform the additional signatures. It could also require developers extra
> work to deal with the additional data.
>=20
> On the other hand, since often packages carry the file digests themselves=
,
> it won't be actually needed to add file signatures. If the kernel was abl=
e
> to extract the file digests by itself, all the tasks mentioned above for
> the Linux distribution vendors won't be needed too. All current and past
> Linux distributions can be easily retrofitted to enable IMA appraisal wit=
h
> the file digests from the packages.
>=20
> Narrowing down the scope of a package parser to only extract specific
> information makes it small enough to accurately verify that it cannot har=
m
> the kernel. An additional mitigation consists in verifying the signature =
of
> the package first, before attempting to extract the file digests.
>=20
>=20
> Solution
> =3D=3D=3D=3D=3D=3D=3D=3D
>=20
> To avoid a PCR is extended in a non-deterministic way, the proposed
> solution is to replace individual file measurements with the measurement =
of
> a file (the digest list) containing a set of file digests. If the
> calculated digest of a file being measured/appraised matches one digest i=
n
> the set, its measurement is skipped. If otherwise there is no match, the
> file digest is added to the measurement list.
>=20
> The resulting measurement list, which cannot be done on the default IMA P=
CR
> to avoid ambiguity with the default-style measurement, has the following
> meaning: none/some/all files represented with the measurement of the dige=
st
> lists COULD have been accessed, without knowing IF and WHEN. Any other
> measurement (other than boot_aggregate) is of a file whose digest was not
> included in the digest list.
>=20
> File signatures have a coarser granularity, it is per-signing key and not
> per-package. A measurement list containing just the measurement of the
> signing keys and the files without/invalid signature (those with valid
> signature would be skipped) would be even less accurate.
>=20
> To ensure a rapid and smooth deployment of IMA appraisal, the kernel has
> been provided with the ability to extract file digests from the RPM
> package headers, and add them to the kernel memory on demand (only when a
> file from a given package is accessed). This ensures that the memory
> consumption for this new feature is directly proportional to the usage of
> the system.
>=20
>=20
> Scope
> =3D=3D=3D=3D=3D
>=20
> The integrity digest cache enables IMA to extend a PCR (not the default
> one) in a deterministic fashion, and to appraise immutable files with fil=
e
> digests from the packages, when no other appraisal method is available. I=
t
> does not yet support metadata verification with Extended Verification
> Module (EVM), for which a separate patch set will be provided.
>=20
>=20
> Design
> =3D=3D=3D=3D=3D=3D
>=20
> The digest cache is a hash table of file digests, attached to the inode o=
f
> the digest list from which file digests are extracted. It is accessible,
> when a given file is being measured/appraised, from the new xattr
> security.digest_list, containing the path of the digest list itself.
>=20
> If the calculated file digest is found in the digest cache, its measureme=
nt
> is avoided, or read-only access is granted if appraisal is in enforcing
> mode. Read-write access is prevented to avoid updating an unverified HMAC
> of file metadata.
>=20
> The digest cache can be used only if the following conditions are met:
>=20
> - The 'digest_cache=3Dcontent' keyword is added to the desired IMA policy
>   rules;
> - If the rule action is 'measure', a PCR different from the default one
>   is specified;
> - If the rule action is 'appraise', 'digest_cache=3Dcontent' and
>   'appraise_type' don't appear at the same time;
> - The same action for which the digest cache is used was done also on the
>   digest list;
> - The digest cache is not (currently) used for measurement/appraisal of
>   other digest lists.
>=20
> For performance reasons, the digest cache is attached to every inode usin=
g
> it, since multiple hooks can be invoked on it before the
> measurement/appraisal result is cached. A reference count indicates how
> many inodes use it, and only when it reaches zero, the digest cache can b=
e
> freed (for example when inodes are evicted from memory).
>=20
> Two digest cache pointers have been added to the iint to distinguish for
> which purpose they should be used: dig_owner points to the digest cache
> created from the same inode the iint refers to, and should be used for
> measurement/appraisal of other inodes; dig_user points to the digest
> cache created from a different inode, and requested for
> measurement/appraisal. One digest cache pointer would be confusing, as
> for digest lists the digest cache was created from them, but IMA would
> try to use that digest cache for measurement/appraisal of itself.
>=20
> Finally, at the first digest list measurement, an iterator is executed to
> sequentially read (not parse) all the digest lists in the same directory,
> so that the PCR is extended in a deterministic fashion. The other
> concurrent users of the digest cache have to wait until the iterator
> finishes.
>=20
>=20
> API
> =3D=3D=3D
>=20
> digest_cache_alloc(), digest_cache_parse_digest_list() and
> digest_cache_new() are internal functions used during the creation and
> initialization of the digest cache.
>=20
> digest_cache_get() and digest_cache_free() are called by the user of the
> digest cache (e.g. IMA), to obtain and free a digest cache.
>=20
> digest_cache_init_htable(), digest_cache_add() and digest_cache_lookup()
> are called by the digest list parsers to populate and search in a digest
> cache.
>=20
>=20
> Digest List Formats
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>=20
> tlv
> ~~~
>=20
> The Type-Length-Value (TLV) format was chosen for its extensibility.
> Additional fields can be added without breaking compatibility with old
> versions of the parser.
>=20
> The layout of a tlv digest list is the following:
>=20
>  [header: DIGEST_LIST_FILE, num fields, total len]
>  [field: DIGEST_LIST_ALGO, length, value]
>  [field: DIGEST_LIST_ENTRY#1, length, value (below)]
>   |- [header: DIGEST_LIST_FILE, num fields, total len]
>   |- [ENTRY#1_DIGEST, length, file digest]
>   |- [ENTRY#1_PATH, length, file path]
>  [field: DIGEST_LIST_ENTRY#N, length, value (below)]
>   |- [header: DIGEST_LIST_FILE, num fields, total len]
>   |- [ENTRY#N_DIGEST, length, file digest]
>   |- [ENTRY#N_PATH, length, file path]
>=20
> DIGEST_LIST_ALGO is a field to specify the algorithm of the file digest.
> DIGEST_LIST_ENTRY is a nested TLV structure with the following fields:
> ENTRY_DIGEST contains the file digest; ENTRY_PATH contains the file path.
>=20
>=20
> rpm
> ~~~
>=20
> The rpm digest list is basically a subset of the RPM package header.
> Its format is:
>=20
>  [RPM magic number]
>  [RPMTAG_IMMUTABLE]
>=20
> RPMTAG_IMMUTABLE is a section of the full RPM header containing the part
> of the header that was signed, and whose signature is stored in the
> RPMTAG_RSAHEADER section.
>=20
>=20
> Appended Signature
> ~~~~~~~~~~~~~~~~~~
>=20
> Digest lists can have a module-style appended signature, that can be used
> for appraisal with IMA. The signature type can be PKCS#7, as for kernel
> modules, or the new user asymmetric key signature.
>=20
>=20
> History
> =3D=3D=3D=3D=3D=3D=3D
>=20
> The original name of this work was IMA Digest Lists, which was somehow
> considered too invasive. The code was moved to a separate component named
> DIGLIM (DIGest Lists Integrity Module), with the purpose of removing the
> complexity away of IMA, and also add the possibility of using it with oth=
er
> kernel components (e.g. Integrity Policy Enforcement, or IPE).
>=20
> Since it was originally proposed, in 2017, this work grew up a lot thanks
> to various comments/suggestions. It became integrally part of the openEul=
er
> distribution since end of 2020.
>=20
> There are significant differences between this and the previous versions.
> The most important one is moving from a centralized repository of file
> digests to a per-package repository. This significantly reduces the memor=
y
> pressure, since digest lists are loaded into kernel memory only when they
> are actually needed. Also, file digests are automatically unloaded from
> kernel memory at the same time inodes are evicted from memory during
> reclamation.
>=20
>=20
> Performance
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>=20
> The tests have been performed on a Fedora 38 virtual machine, with 8 core=
s
> (AMD EPYC-Rome), 4GB of RAM, TPM passthrough. The signing key is an ECDSA
> NIST P-384.
>=20
> IMA measurement policy: no cache
> ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>=20
>  dont_measure fsmagic=3D0x01021994
>  measure func=3DBPRM_CHECK
>  measure func=3DMMAP_CHECK
>=20
>=20
> IMA measurement policy: cache
> ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>=20
>  dont_measure fsmagic=3D0x01021994
>  measure func=3DDIGEST_LIST_CHECK template=3Dima-modsig pcr=3D11
>  measure func=3DBPRM_CHECK digest_cache=3Dcontent pcr=3D11
>  measure func=3DMMAP_CHECK digest_cache=3Dcontent pcr=3D11
>=20
>=20
> IMA Measurement Results
> ~~~~~~~~~~~~~~~~~~~~~~~
>=20
>                                +-----------+-----------+-----------+
>                                | # measur. | boot time |   slab    |
>  +-----------------------------+-----------+-----------+-----------+
>  | measure (no cache)          |    389    |  12.682s  | 231453 KB |
>  +-----------------------------+-----------+-----------+-----------+
>  | measure (cache, no iter)    |    175    |  12.283s  | 234224 KB |
>  +-----------------------------+-----------+-----------+-----------+
>  | measure (cache, iter)       |    853    |  16.430s  | 238491 KB |
>  +-----------------------------+-----------+-----------+-----------+
>=20
> With the iterator enabled, all 852 packages are measured. Consequently, t=
he
> boot time is longer. One possible optimization would be to exclude the
> packages that don't include measured files. By disabling the iterator, it
> can be seen that the packages actually used are 174 (one measurement is f=
or
> boot_aggregate).
>=20
>=20
> IMA appraisal policy: no cache
> ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>=20
>  dont_appraise fsmagic=3D0x01021994
>  appraise func=3DBPRM_CHECK appraise_type=3Dimasig
>  appraise func=3DMMAP_CHECK appraise_type=3Dimasig
>=20
>=20
> IMA appraisal policy: cache
> ~~~~~~~~~~~~~~~~~~~~~~~~~~~
>=20
>  dont_appraise fsmagic=3D0x01021994
>  appraise func=3DDIGEST_LIST_CHECK appraise_type=3Dimasig|modsig
>  appraise func=3DBPRM_CHECK digest_cache=3Dcontent
>  appraise func=3DMMAP_CHECK digest_cache=3Dcontent
>=20
>=20
> IMA Appraisal Results
> ~~~~~~~~~~~~~~~~~~~~~
>=20
>                                +-----------+-----------+
>                                | boot time |   slab    |
>  +-----------------------------+-----------+-----------+
>  | appraise (no cache)         |  11.995s  | 231145 KB |
>  +-----------------------------+-----------+-----------+
>  | appraise (cache)            |  11.879s  | 233091 KB |
>  +-----------------------------+-----------+-----------+
>=20
> In this test, it can be seen that the performance of the two solutions ar=
e
> comparable, with the digest cache slightly ahead. The difference could be
> more substantial with more file appraised.
>=20
>=20
> How to Test
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>=20
> First, it is necessary to copy the new kernel headers (tlv_parser.h,
> uasym_parser.h, tlv_digest_list.h) from usr/include/linux in the kernel
> source directory to /usr/include/linux.
>=20
> Then, gpg must be rebuilt with the additional patches to convert the PGP
> keys of the Linux distribution to the new user asymmetric key format:
>=20
>  $ gpg --conv-kernel <path of PGP key> >> certs/uasym_keys.bin
>=20
> This embeds the converted keys in the kernel image. Then, the following
> kernel options must be enabled:
>=20
>  CONFIG_INTEGRITY_DIGEST_CACHE=3Dy
>  CONFIG_UASYM_KEYS_SIGS=3Dy
>  CONFIG_UASYM_PRELOAD_PUBLIC_KEYS=3Dy
>=20
> and the kernel must be rebuilt with the patches applied. After boot, it i=
s
> necessary to build and install the digest list tool in tools/digest-lists=
,
> and to execute (as root):
>=20
>  # manage_digest_lists -o gen -d /etc/digest_lists -i rpmdb -f rpm
>=20
> The new gpg must also be installed in the system, as it will be used to
> convert the PGP signatures of the RPM headers to the user asymmetric key
> format.
>=20
> It is recommended to create an additional digest list with the following
> files, by creating a file named 'list' with the content:
>=20
>  /usr/bin/manage_digest_lists
>  /usr/lib64/libgen-tlv-list.so
>  /usr/lib64/libgen-rpm-list.so
>  /usr/lib64/libparse-rpm-list.so
>  /usr/lib64/libparse-tlv-list.so
>=20
> Then, to create the digest list, it is sufficient to execute:
>=20
>  # manage_digest_lists -i list -L -d /etc/digest_lists -o gen -f tlv
>=20
> If appraisal is enabled and in enforcing mode, it is necessary to sign th=
e
> new digest list, with the sign-file tool in the scripts/ directory of the
> kernel sources:
>=20
>  # scripts/sign-file sha256 certs/signing_key.pem certs/signing_key.pem /=
etc/digest_lists/tlv-list
>=20
> The final step is to add security.digest_list to each file with:
>=20
>  # manage_digest_lists -i /etc/digest_lists -o add-xattr
>=20
> After that, it is possible to test the integrity digest cache with the
> following policy written to /etc/ima/ima-policy:
>=20
>  dont_measure fsmagic=3D0x01021994
>  measure func=3DDIGEST_LIST_CHECK template=3Dima-modsig pcr=3D11
>  measure func=3DBPRM_CHECK digest_cache=3Dcontent pcr=3D11
>  measure func=3DMMAP_CHECK digest_cache=3Dcontent pcr=3D11
>  dont_appraise fsmagic=3D0x01021994
>  appraise func=3DBPRM_CHECK digest_cache=3Dcontent
>  appraise func=3DMMAP_CHECK digest_cache=3Dcontent
>  appraise func=3DDIGEST_LIST_CHECK appraise_type=3Dimasig|modsig
>=20
> Tmpfs is excluded for now, until memfd is properly handled.
>=20
> Before loading the policy, it is possible to enable dynamic debug to see
> which operations are done by the integrity digest cache:
>=20
>  # echo "file tlv* +p" > /sys/kernel/debug/dynamic_debug/control
>  # echo "file rpm* +p" > /sys/kernel/debug/dynamic_debug/control
>  # echo "file digest* +p" > /sys/kernel/debug/dynamic_debug/control
>=20
> Alternatively, the same strings can be set as value of the dyndbg=3D opti=
on
> in the kernel command line.
>=20
> A preliminary test, before booting the system with the new policy, is to
> supply the policy to IMA in the current system with:
>=20
>  # cat /etc/ima/ima-policy > /sys/kernel/security/ima/policy
>=20
> If that worked, the system can be rebooted. Systemd will take care of
> loading the IMA policy at boot. The instructions have been tested on a
> Fedora 38 OS.
>=20
> After boot, it is possible to check the content of the measurement list:
>=20
>  # cat /sys/kernel/security/ima/ascii_runtime_measurements
>=20
> If only the files shipped with Fedora 38 have been executed, the
> measurement list will contain only the digest lists, and not the individu=
al
> files.
>=20
> Another test is to ensure that IMA prevents the execution of unknown file=
s:
>=20
>  # cp -a /bin/cat .
>  # ./cat
>=20
> That will work. But not on the modified binary:
>=20
>  # echo 1 >> cat
>  # cat
>  -bash: ./cat: Permission denied
>=20
> Execution will be denied, and a new entry in the measurement list will
> appear (it would be probably ok to not add that entry, as access to the
> file was denied):
>=20
>  11 50b5a68bea0776a84eef6725f17ce474756e51c0 ima-ng sha256:15e1efee080fe5=
4f5d7404af7e913de01671e745ce55215d89f3d6521d3884f0 /root/cat
>=20
> Finally, it is possible to test the shrinking of the digest cache, by
> forcing the kernel to evict inodes from memory:
>=20
>  # echo 3 > /proc/sys/vm/drop_caches
>=20
> The kernel log should have messages like:
>=20
>  [  313.032536] DIGEST CACHE: Remove digest sha256:102900208eef27b7663801=
35906d431dba87edaa7ec6aa72e6ebd3dd67f3a97b from digest list /etc/digest_lis=
ts/rpm-libseccomp-2.5.3-4.fc38.x86_64
>=20
>=20
> Patch set dependencies
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>=20
> This patch set depends on:
>=20
> https://lore.kernel.org/linux-integrity/20230720153247.3755856-2-roberto.=
sassu@huaweicloud.com/
>=20
> which allows to appraise RPM package headers with the PGP keys of Linux
> distribution vendors.
>=20
>=20
> Patch set content
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>=20
> Patch 1 introduces a new hook to identify the loading of digest lists and
> consequently appraise them.
>=20
> Patches 2-4 implement the digest cache, and an iterator to prefetch the
> digest lists to measure them in a deterministic way.
>=20
> Patches 5-6 implement the currently supported digest list formats: tlv an=
d
> rpm. The tlv format relies on the TLV parser defined in the patch set
> mentioned above.
>=20
> Patches 7-9 enable the usage of the digest cache in IMA for measurement a=
nd
> appraisal.
>=20
> Patches 10-12 add a tool to manage digest lists.
>=20
> Patch 13 adds the documentation of the integrity digest cache.
>=20
>=20
> Changelog
> =3D=3D=3D=3D=3D=3D=3D=3D=3D
>=20
> v1:
> - Add documentation in Documentation/security/integrity-digest-cache.rst
> - Pass the mask of IMA actions to digest_cache_alloc()
> - Add a reference count to the digest cache
> - Remove the path parameter from digest_cache_get(), and rely on the
>   reference count to avoid the digest cache disappearing while being used
> - Rename the dentry_to_check parameter of digest_cache_get() to dentry
> - Rename digest_cache_get() to digest_cache_new() and add
>   digest_cache_get() to set the digest cache in the iint of the inode for
>   which the digest cache was requested
> - Add dig_owner and dig_user to the iint, to distinguish from which inode
>   the digest cache was created from, and which is using it; consequently =
it
>   makes the digest cache usable to measure/appraise other digest caches
>   (support not yet enabled)
> - Add dig_owner_mutex and dig_user_mutex to serialize accesses to dig_own=
er
>   and dig_user until they are initialized
> - Enforce strong synchronization and make the contenders wait until
>   dig_owner and dig_user are assigned to the iint the first time
> - Move checking IMA actions on the digest list earlier, and fail if no
>   action were performed (digest cache not usable)
> - Remove digest_cache_put(), not needed anymore with the introduction of
>   the reference count
> - Fail immediately in digest_cache_lookup() if the digest algorithm is
>   not set in the digest cache
> - Use 64 bit mask for IMA actions on the digest list instead of 8 bit
> - Return NULL in the inline version of digest_cache_get()
> - Use list_add_tail() instead of list_add() in the iterator
> - Copy the digest list path to a separate buffer in digest_cache_iter_dir=
()
> - Use digest list parsers verified with Frama-C
> - Explicitly disable (for now) the possibility in the IMA policy to use t=
he
>   digest cache to measure/appraise other digest lists
> - Replace exit(<value>) with return <value> in manage_digest_lists.c
>=20
> Roberto Sassu (13):
>   ima: Introduce hook DIGEST_LIST_CHECK
>   integrity: Introduce a digest cache
>   integrity/digest_cache: Add functions to populate and search
>   integrity/digest_cache: Prefetch digest lists in a directory
>   integrity/digest_cache: Parse tlv digest lists
>   integrity/digest_cache: Parse rpm digest lists
>   ima: Add digest_cache policy keyword
>   ima: Use digest cache for measurement
>   ima: Use digest cache for appraisal
>   tools: Add tool to manage digest lists
>   tools/digest-lists: Add tlv digest list generator and parser
>   tools/digest-lists: Add rpm digest list generator and parser
>   docs: Add documentation of the integrity digest cache
>=20
>  Documentation/ABI/testing/ima_policy          |   6 +-
>  Documentation/security/index.rst              |   1 +
>  .../security/integrity-digest-cache.rst       | 484 ++++++++++++++++++
>  MAINTAINERS                                   |   2 +
>  include/linux/kernel_read_file.h              |   1 +
>  include/uapi/linux/tlv_digest_list.h          |  59 +++
>  include/uapi/linux/xattr.h                    |   3 +
>  security/integrity/Kconfig                    |  12 +
>  security/integrity/Makefile                   |   4 +
>  security/integrity/digest_cache.c             | 454 ++++++++++++++++
>  security/integrity/digest_cache.h             | 110 ++++
>  security/integrity/digest_cache_iter.c        | 160 ++++++
>  .../integrity/digest_list_parsers/parsers.h   |  15 +
>  security/integrity/digest_list_parsers/rpm.c  | 215 ++++++++
>  security/integrity/digest_list_parsers/tlv.c  | 188 +++++++
>  security/integrity/iint.c                     |  12 +
>  security/integrity/ima/ima.h                  |  16 +-
>  security/integrity/ima/ima_api.c              |  22 +-
>  security/integrity/ima/ima_appraise.c         |  16 +-
>  security/integrity/ima/ima_main.c             |  40 +-
>  security/integrity/ima/ima_policy.c           |  59 ++-
>  security/integrity/integrity.h                |   8 +
>  tools/Makefile                                |  16 +-
>  tools/digest-lists/.gitignore                 |   7 +
>  tools/digest-lists/Makefile                   |  72 +++
>  tools/digest-lists/common.c                   | 163 ++++++
>  tools/digest-lists/common.h                   |  90 ++++
>  tools/digest-lists/generators/generators.h    |  18 +
>  tools/digest-lists/generators/rpm.c           | 257 ++++++++++
>  tools/digest-lists/generators/tlv.c           | 168 ++++++
>  tools/digest-lists/manage_digest_lists.c      | 349 +++++++++++++
>  tools/digest-lists/manage_digest_lists.txt    |  82 +++
>  tools/digest-lists/parsers/parsers.h          |  16 +
>  tools/digest-lists/parsers/rpm.c              | 169 ++++++
>  tools/digest-lists/parsers/tlv.c              | 195 +++++++
>  tools/digest-lists/parsers/tlv_parser.h       |  38 ++
>  36 files changed, 3501 insertions(+), 26 deletions(-)
>  create mode 100644 Documentation/security/integrity-digest-cache.rst
>  create mode 100644 include/uapi/linux/tlv_digest_list.h
>  create mode 100644 security/integrity/digest_cache.c
>  create mode 100644 security/integrity/digest_cache.h
>  create mode 100644 security/integrity/digest_cache_iter.c
>  create mode 100644 security/integrity/digest_list_parsers/parsers.h
>  create mode 100644 security/integrity/digest_list_parsers/rpm.c
>  create mode 100644 security/integrity/digest_list_parsers/tlv.c
>  create mode 100644 tools/digest-lists/.gitignore
>  create mode 100644 tools/digest-lists/Makefile
>  create mode 100644 tools/digest-lists/common.c
>  create mode 100644 tools/digest-lists/common.h
>  create mode 100644 tools/digest-lists/generators/generators.h
>  create mode 100644 tools/digest-lists/generators/rpm.c
>  create mode 100644 tools/digest-lists/generators/tlv.c
>  create mode 100644 tools/digest-lists/manage_digest_lists.c
>  create mode 100644 tools/digest-lists/manage_digest_lists.txt
>  create mode 100644 tools/digest-lists/parsers/parsers.h
>  create mode 100644 tools/digest-lists/parsers/rpm.c
>  create mode 100644 tools/digest-lists/parsers/tlv.c
>  create mode 100644 tools/digest-lists/parsers/tlv_parser.h
>=20


