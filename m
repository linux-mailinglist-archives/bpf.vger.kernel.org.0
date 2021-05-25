Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B99CC390D14
	for <lists+bpf@lfdr.de>; Wed, 26 May 2021 01:52:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232129AbhEYXxo (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 25 May 2021 19:53:44 -0400
Received: from sonic317-39.consmr.mail.ne1.yahoo.com ([66.163.184.50]:33957
        "EHLO sonic317-39.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232109AbhEYXxo (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 25 May 2021 19:53:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1621986733; bh=mvSm0zmB+BMDw2EKW2It3WUM0gYqaOcZAoXM7pXqn1w=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject:Reply-To; b=GLo2F00xV3u/FBAegG7qkuIoOWBH7oBQSsqXLHsmyahkLaqQxTT5hQCYcv3A0TafXq4SeFIraVyD+pAv0UGIZOg+OcvZW7WM0Dk1B8Rr47mZKL15MQqOnqYwPuA/9CknL4ffOgA062myaFKRkOIFgTIY5EGEW/fhqIosBLiIUa6lgutGoRhUnw+ty/hKl4ah3BxazR9sKsqYIQyWwpKKCvbNo91Ff5LdUl57f0Xhn+pwmVUSubDCP4ZQNB1SkIxmhpePjo+2c1apAyMQbAnamyWTRznC1ZpdfVlMtWWMn+gnJqj+uYGpN6ZL2Nc8hNey73sAGTE79p6rjJGLFpMUdQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1621986733; bh=wNuejBqKJ7ctnZM0M5WFZATsvnuGhaU6fz39A2LDlnV=; h=X-Sonic-MF:Subject:To:From:Date:From:Subject; b=klnXxas0vYUIeNZAMKwDYDORnzA0PvXcd3Axj+R0n0/QaQ1wDP2Y5yG+NYGO7AkbdiCAub74EyJRx2LZTnTBjfSSejMJjGj/o8QyfSyvaJaMwi+3lwheRvpLxKu9yOGiMPy9QzfTX6CUXa0idvwVdmb/BNmj5FgAoESeoLu2cNHKI4A7+I+wjLZZqfibBFLddY2VsLIrqvPJj4ccH2EEPDPR89lqa3kn6HQcI5VeMmemWhvgM/SQaZrNGWEZCIKE7733uiWnIy5ZSWC1bhp3HLuGfmIGL+RDjN/oVgRxoBMtM+U+Sq+bhcIJMW3pJIwoGsWVHNSBm99EpaG6neyItg==
X-YMail-OSG: TaRZgA4VM1n7xSF0eWa6YQivGmWdn3Lw0zvQ7IW3EJ4HiWYi.EV_ENxX0Sx_hh7
 tBCcVTIDYNqPV291z5CtN334GuQ1ZQQKTjnNMLGMorlbAcnk5bVdBzvPIVl2pJgddTduozD6gmOI
 iOSZWeMqEpj1xgkPz1FnjAc_ies0Ixfmfb6l9.Ez.8uVmLyPGvH8PAKdO2gEasN1Uy9xY3sbrF92
 OoiVxFHMBmn41afghWjwXtC1uy4b2jpOVX.dPeExnOba6SfvdmaXalAb_XTdxPWm6YfwNJVSqbTI
 WxjzukKVwT.ytZkEoxplF3ygzHs3JRNe4eOONVguj97gBshco4r8lJuhQkIiszcHDKOiRBqu0D1t
 LgjmGAnOuiX2JkIYIP58B7hn_BwRcItEX8s1TxSnNG1pScb7_jHn8sQG2_hEf0JgFSJMGU7Htb6K
 R7RXhrhjrYi7krxFDXZphJYmRKsMNGe8nRwFh0IclY4fFiCvhDtqZdEmHqYtDLB2OQ4k1btRREgB
 KXLbXXfI2MpNMl3tIKci4YibdOyXw2MUCKxc.B8y3ocrKKAnpeQJyPpO6HunzV69CRN80MJ39jUa
 MXlFirpwVZLNiRWA_i77k6iUZ2mN4ARXhPX2aT37M8i5uV76xCF9eZH3snpNwKbVlvcDJBycnLyU
 XgiNZRty2IvbiJFlFBjvnB8CYp7lDx.FrNaTb9Wa4_j7yu.UBRWitdglWm38cqYGlGc05PMW86wJ
 csVYH.yEtD1BDf8pDEnsmyUp0a6q2L62had9G.EPRzj9vcdXu5EmfXsTaX0_aSIbO3BASOgEPYSr
 pxK4VKHY.7QUv1CSVHPI.3zcxHK9m.2ioV.w3ItlK6uZ0KfwNVMa44rEkqwAX5gJCpeoUvUSFwKZ
 EBOdWis4GQ3egPHrIJ33rJHF42nKkyG6YBUwD7vMOcwbk7Ma.hfDjF4.wYRGTXg5FuW9RjtGwqeV
 ZEcPwkHF93FEWE46l0XDC07F8WWMVfE8s_QurfGSktfpGVjpRGyCC8lxn786cwlLJ_NUZH0lexZC
 QOWvH3hhF8inaflJ2EN5OHPF5Y3y1teEnm51lzBv2YgZY0ylpa9ck5_5dG5fDZZBti6J2zzcRIwk
 SUQ7xARc5KvGeuVNlK6QIU4oDltblFEw28Nb6b.GzVhcLxaLN9bELS5HIfQ6BNl_Qp8se4K0gZiO
 tkseegq96Q6k2nJApkcjVpe1nCmot4blgR.8u_lVTvm0uETh70H1m5f6M14lBJrjgctbHSJn4T_g
 3IoR8t5m9VCPSuapIOCEXzuJqNyHL_l1Wbwsj4RFwWPyIaj8ff.EWLm_TgSIsVsEqPFmPzeU0YLk
 MRRFmVvaYgbLHHC0mYOt3TWZ2dUtEMca335tL6vK.14p0Hv.Kgl9Peh7MZI5xpOXcPFq8p9SB6A5
 ENop.27z1BxKTv.sganZZ231a_5EZzlwXDxKdO0.HRaS1qkKpc4FFqvn9QlJQ39BFFqheylaYZo6
 kbcKKebi5xzVs61e4rFRk_n02wyzP8F2zTvXv6ZZlje.Wrt1tOeolfCR1jdvZm4XSUbGzbnd3A_W
 lxCeSYN5dbiG.2WAbQq7.aqRlLs8Cm5S_Hzc.QevsH9aLb1iSWWs2ho3i6PgBEluMMWitXSjAx7x
 MnglxdwhpkV796EppGbiqSEib8oi.qb9xwXxa95jLIH6AXHnVCctpUqmyku1o72Hhu9i_Em3iOsC
 dwbf6nviNfFwyCAammAdCG8f_qRnWpSulAw1_.xiI7ApZcCMiOYh_oR7eMvFJKjW1A88i4Hb3RPz
 1braXcMj_xAR8YBvcQ52POONZQL7pbhXeNT5vD_F297FMONM7TBbfs6j2e3aRS6e0zSRPnaRpQNe
 Pll7m5lUzdUkLzA5deDPE9TFbHTnE90qjwZ67l.vC.QU.k_zDo7fHAirSdSwgezx6QibZ3lFkU6U
 79zt3TY8kVIWjZTkcn.iyBhHPTiS6JLFq_MqQrNJTWCN08IKQqOFbG2A0vaGAlq68udw_hhUpRNP
 Ekp_9TsTdHqDrTma9PmqpO5o4TCsZKn39L1hJxVX3tgJPt17dhhZ3LeAov68YJ_7bpbKCpNOIX6q
 38CKmBZ_aSDvk9LI90TXiOMzn3W6W5rApIwiFuCmMgKK.9owjUDZNQUfBDu6B5m2fo4AllB4rdTQ
 2TuUHoE8rCpzGMf7.mkbYuGT4rqC2Id8aW_5OlWrbLGXGoVAJgiYRkQ6SHGN7gB7d5zWfFhVRfuT
 KVlLcO_XXorfz4znA8yGtoPMGiyXtSLb25Mx0EiiBzt4Mi2A8lMM0.x8F7EtfjGALj67glO3Np5A
 Ql1dxDO_r4ZiYNtMk.v_lHRyugf6R_d4IZpwMcmid_gifMF_v12mE9vLCbOGhusAhEeQuPPC0elO
 Jnf3PzIHhpmBRzLDTA70wRAvX9.WWka.c93924FLdeH5FwCxkDaiPnsthhpGcLOE_GByl5LlFk7b
 A3Fw.fcEdlB_OSK6aRHPBVLi7LAwg5xehZ5IRJzyuZL3.cMFFAiuYaE_Ac1e3CiQDW6wpwODsBbl
 dtQa8ZKu3mCKV2Pzs2m67.V69ODvgORuWh41SuKNm2dHFjhiJpUHtCOoYYMbaGst271OPGxF5Acw
 x8JziJbhxoazcNvQbx4BrMBkwuuERbsn_bR18eD.8yqm7Hcz1dYX3KZM42DnuI1wEgR3hdawrsD9
 YVrXCcFGYbj2c6beLk7z39.n.2PpqZtZAf2zfyGZXRSsSOXW.CJokwvp5X7jKdFHi6rktPyBR8ih
 YzTSsYCqN6sXVKEkIH5kiG6fFTRP3rHNnf3C0pWbV6y8w3XE0dwciqDGMrptS9xaecWtHqYQV.A0
 gI3c1V_MEy9FYkpgcablGJIUPI8yfMCvhd8W5JgbaTWQASgxBSsS20Hfe.ZYe3tC.7J9pGHue8tZ
 8uf7qFw5ppTnrw1UnNgfxFUVs4IMjHphyPEkNCeEXU5iVTDxWcdXADdVtuJ5xpv.pnerj14YajF1
 4xVF.bFLxtte4L49Eg28T9v60ENsyC7BKx.s4oSghLcoY9hnx9ItYn16w4_DpglI75mp1PQtVegm
 GC4Tqr1c8I7CuEa13iBtDitmvET1SOzYsPX5N8CgwWCJQHqPKHp_mq4BtYuqjeg2hsGao4nx23DK
 kJQM34tz3CdqsawsJph4P.xo4Tqze7lsobK9XqjTFdQMaRZLQpYA-
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic317.consmr.mail.ne1.yahoo.com with HTTP; Tue, 25 May 2021 23:52:13 +0000
Received: by kubenode565.mail-prod1.omega.gq1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID 37ef89f8728ecb08423fd6b99f8ccf9e;
          Tue, 25 May 2021 23:52:11 +0000 (UTC)
Subject: Re: [PATCH v26 02/25] LSM: Add the lsmblob data structure.
To:     =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@digikod.net>,
        casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     linux-audit@redhat.com, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        paul@paul-moore.com, sds@tycho.nsa.gov,
        linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
        Casey Schaufler <casey@schaufler-ca.com>
References: <20210513200807.15910-1-casey@schaufler-ca.com>
 <20210513200807.15910-3-casey@schaufler-ca.com>
 <206971d6-70c7-e217-299f-1884310afa15@digikod.net>
From:   Casey Schaufler <casey@schaufler-ca.com>
Message-ID: <1c3874c1-870a-ac60-03e6-2c16d49e185b@schaufler-ca.com>
Date:   Tue, 25 May 2021 16:52:10 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <206971d6-70c7-e217-299f-1884310afa15@digikod.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
X-Mailer: WebService/1.1.18368 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 5/22/2021 1:39 AM, Micka=C3=ABl Sala=C3=BCn wrote:
> I like this design but there is an issue with Landlock though, see belo=
w.
>
> On 13/05/2021 22:07, Casey Schaufler wrote:
>> When more than one security module is exporting data to
>> audit and networking sub-systems a single 32 bit integer
>> is no longer sufficient to represent the data. Add a
>> structure to be used instead.
>>
>> The lsmblob structure is currently an array of
>> u32 "secids". There is an entry for each of the
>> security modules built into the system that would
>> use secids if active. The system assigns the module
>> a "slot" when it registers hooks. If modules are
>> compiled in but not registered there will be unused
>> slots.
>>
>> A new lsm_id structure, which contains the name
>> of the LSM and its slot number, is created. There
>> is an instance for each LSM, which assigns the name
>> and passes it to the infrastructure to set the slot.
>>
>> The audit rules data is expanded to use an array of
>> security module data rather than a single instance.
>> Because IMA uses the audit rule functions it is
>> affected as well.
>>
>> Acked-by: Stephen Smalley <sds@tycho.nsa.gov>
>> Acked-by: Paul Moore <paul@paul-moore.com>
>> Acked-by: John Johansen <john.johansen@canonical.com>
>> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
>> Cc: <bpf@vger.kernel.org>
>> Cc: linux-audit@redhat.com
>> Cc: linux-security-module@vger.kernel.org
>> Cc: selinux@vger.kernel.org
>> To: Mimi Zohar <zohar@linux.ibm.com>
>> To: Micka=C3=ABl Sala=C3=BCn <mic@linux.microsoft.com>
>> ---
>>  include/linux/audit.h               |  4 +-
>>  include/linux/lsm_hooks.h           | 12 ++++-
>>  include/linux/security.h            | 67 +++++++++++++++++++++++++--
>>  kernel/auditfilter.c                | 24 +++++-----
>>  kernel/auditsc.c                    | 13 +++---
>>  security/apparmor/lsm.c             |  7 ++-
>>  security/bpf/hooks.c                | 12 ++++-
>>  security/commoncap.c                |  7 ++-
>>  security/integrity/ima/ima_policy.c | 40 +++++++++++-----
>>  security/landlock/cred.c            |  2 +-
>>  security/landlock/fs.c              |  2 +-
>>  security/landlock/ptrace.c          |  2 +-
>>  security/landlock/setup.c           |  4 ++
>>  security/landlock/setup.h           |  1 +
>>  security/loadpin/loadpin.c          |  8 +++-
>>  security/lockdown/lockdown.c        |  7 ++-
>>  security/safesetid/lsm.c            |  8 +++-
>>  security/security.c                 | 72 ++++++++++++++++++++++++----=
-
>>  security/selinux/hooks.c            |  8 +++-
>>  security/smack/smack_lsm.c          |  7 ++-
>>  security/tomoyo/tomoyo.c            |  8 +++-
>>  security/yama/yama_lsm.c            |  7 ++-
>>  22 files changed, 262 insertions(+), 60 deletions(-)
>>
> [...]
>
>> diff --git a/security/landlock/setup.c b/security/landlock/setup.c
>> index f8e8e980454c..4a12666a4090 100644
>> --- a/security/landlock/setup.c
>> +++ b/security/landlock/setup.c
>> @@ -23,6 +23,10 @@ struct lsm_blob_sizes landlock_blob_sizes __lsm_ro_=
after_init =3D {
>>  	.lbs_superblock =3D sizeof(struct landlock_superblock_security),
>>  };
>> =20
>> +struct lsm_id landlock_lsmid __lsm_ro_after_init =3D {
>> +	.lsm =3D LANDLOCK_NAME,
> It is missing: .slot =3D LSMBLOB_NEEDED,

Sorry for the delay.

Landlock does not provide any of the hooks that use a struct lsmblob.
That would be secid_to_secctx, secctx_to_secid, inode_getsecid,
cred_getsecid, kernel_act_as task_getsecid_subj task_getsecid_obj and
ipc_getsecid. Setting .slot =3D LSMBLOB_NEEDED indicates that the LSM
uses a slot in struct lsmblob. Landlock does not need a slot.

>
> You can run the Landlock tests please?
> make -C tools/testing/selftests TARGETS=3Dlandlock gen_tar
> tar -xf kselftest.tar.gz && ./run_kselftest.sh

Sure. I'll add them to my routine.

>
>
>> +};
>> +
>>  static int __init landlock_init(void)
>>  {
>>  	landlock_add_cred_hooks();
> [...]
>
>> diff --git a/security/security.c b/security/security.c
>> index e12a7c463468..a3276deb1b8a 100644
>> --- a/security/security.c
>> +++ b/security/security.c
>> @@ -344,6 +344,7 @@ static void __init ordered_lsm_init(void)
>>  	init_debug("sock blob size       =3D %d\n", blob_sizes.lbs_sock);
>>  	init_debug("superblock blob size =3D %d\n", blob_sizes.lbs_superbloc=
k);
>>  	init_debug("task blob size       =3D %d\n", blob_sizes.lbs_task);
>> +	init_debug("lsmblob size         =3D %zu\n", sizeof(struct lsmblob))=
;
>> =20
>>  	/*
>>  	 * Create any kmem_caches needed for blobs
>> @@ -471,21 +472,36 @@ static int lsm_append(const char *new, char **re=
sult)
>>  	return 0;
>>  }
>> =20
>> +/*
>> + * Current index to use while initializing the lsmblob secid list.
>> + */
>> +static int lsm_slot __lsm_ro_after_init;
>> +
>>  /**
>>   * security_add_hooks - Add a modules hooks to the hook lists.
>>   * @hooks: the hooks to add
>>   * @count: the number of hooks to add
>> - * @lsm: the name of the security module
>> + * @lsmid: the identification information for the security module
>>   *
>>   * Each LSM has to register its hooks with the infrastructure.
>> + * If the LSM is using hooks that export secids allocate a slot
>> + * for it in the lsmblob.
>>   */
>>  void __init security_add_hooks(struct security_hook_list *hooks, int =
count,
>> -				char *lsm)
>> +			       struct lsm_id *lsmid)
>>  {
>>  	int i;
>> =20
> Could you add a WARN_ON(!lsmid->slot || !lsmid->name) here?

Yes. That's reasonable.

>
>
>> +	if (lsmid->slot =3D=3D LSMBLOB_NEEDED) {
>> +		if (lsm_slot >=3D LSMBLOB_ENTRIES)
>> +			panic("%s Too many LSMs registered.\n", __func__);
>> +		lsmid->slot =3D lsm_slot++;
>> +		init_debug("%s assigned lsmblob slot %d\n", lsmid->lsm,
>> +			   lsmid->slot);
>> +	}
>> +
>>  	for (i =3D 0; i < count; i++) {
>> -		hooks[i].lsm =3D lsm;
>> +		hooks[i].lsmid =3D lsmid;
>>  		hlist_add_tail_rcu(&hooks[i].list, hooks[i].head);
>>  	}
>> =20

