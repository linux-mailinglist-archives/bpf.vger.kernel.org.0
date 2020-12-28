Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E214E2E6A69
	for <lists+bpf@lfdr.de>; Mon, 28 Dec 2020 20:23:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728943AbgL1TXB (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 28 Dec 2020 14:23:01 -0500
Received: from sonic309-27.consmr.mail.ne1.yahoo.com ([66.163.184.153]:33048
        "EHLO sonic309-27.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728985AbgL1TXB (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 28 Dec 2020 14:23:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1609183335; bh=wmHR5RkN8e0OmYbc15Wo0IOIF7ikCoNLvg8LkUAwq4o=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject; b=TPq4cah3Xrh0LA4/UoTs12zE511NPI/1hNulcLPH+5ajji1Er6elnSVWw8I94htyQxtGjTdTa5wrUM0mBjffr7LUPeb+ZwTpssLJ1TABmolqOaXpfZakb8mYS/IyV3yvKQms0AxF6Oef1SGQScx4U6N/MSnlj4lFNwIQRmGrLfV4uIuEcNSQo8Chv+ljUFCOmF/CyU2Ps9V32OCRnGKzEuof7xZSIdV6DrDRP4EoGk/4mlkQlTA2R/Z96ONEc9uU1IBdfqSDMed4Ymo37xNHsi5f8H46Wz2qRJ0iUuKLHbWU4UiNWnQz0PFSKU4VCLArD/9qy0q8jMGL0Dvs+b4z/g==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1609183335; bh=7ihie2lXaLVBJCMe31qwLFQfVpfHoMK6i2yo0gbOQQ4=; h=Subject:To:From:Date:From:Subject; b=ulQMD6NGC7aps2AE5JjFCO4PgT3R+I0MF//yIEuO8NGOdCSCe9lvIom14dJHS9+E3tYjxjkDyM6rkQxoRPQ6SU3aqV8J9XBRNhWQ6LtU+T6Vtn7NWsCsrQbu8ysxFSOZfznFcyeiLlG1BwL9iuAohNBosxCYGgzQ4MdphedoawnqWnuFcaomjXdGIAgrxHEJol3XJXIm/XVzJ92+8h4jeeBH1DjSSPZyLUBPNR8YO/ixomlhp83AEnHs+rnSvhN0qO/rpJChiu61kOFpcKlEtVEGTIEbNnFdQW6QWmgc7JbrHykeL4IUvIUYmwVo7DTtPKO30ZIKYOexQhGuTMPSfA==
X-YMail-OSG: B.M6758VM1kCV9eHCEZRdR5rIzpNkfEQW1nUe8WxD7tCqiLHNcqfqpRwbt828Cx
 PTHF26yFpRgp70Md3KTJ_udD6gAwMm3klH.guu07YsDDQqglR2NrTUiIERkBCA94Drtt8p9iUgxw
 1j_Cd5IjXHxGvnnjG2_oeI4r1emq9oVqdWphEgqRbwXwzGgaJ3orMDOkZg8rGEE8R4jHeh4IXsWy
 ucdm85KnVIEFjAWLLUnzK9hHrCo5ByakLOGFI8T6Lt9k4fF4corX6YHSvOmqkIOYogHfgj9crcWF
 P4WaWErKjlUtdQS4dY1r.6WNTIIizkL3igKmx34cMke_JFdJMrkpsVs8nE8bJYtS3DceYLIqou3v
 XHUBD5.nB1OnPf1sQvN9OcmVQ8wLOAJqzysVhZXc3hDMDtlP1t1tw6i2iAIYsJ0fkMAofoHN4tyM
 Cx2KYdtJ4xyLOp4riZtk6MCWZ._jlttwfJVAn9sNjBNoaOZceKRX3HdYXQmkAmrak5YFPzHO_yp_
 Mjcv4d8VR3KgCWCJhCCIeZv1ERU7e8Lr1SNWR8FdJndC_VTVz1ZqGGMzGuRZl.IUQkepnRoqZy0z
 rsUW3LnIz2gzwT8BuJKqc4C7sj8r623e9evQ21ABTBVg4dYtPV9HYbeNFK1cnDrqzMyeOLQT4d..
 NQjvz2FbsydgFKqkuEFz6stIHo93lcXnZZIUHST3qIb396Ph_8kXqvX7Gcwc_nmIPvdU6cuHRO.L
 5EQjd5PmmG8VShf72zhXIkEBDcHMoaV6a7npcDdNJ3ofJQerXce1pNwY1Y_S6Ccxsb4u1A8g5NwR
 yFBHTu2RSV8VDSWNW02fI9C2BbEXw3J5DWi8O0CrP_JA6T.n.E4AcyrM_DkPrt9.d4fEbABYt0cr
 2PV1d9I91aW2uFpXUjdc1AkHGQVW2VXRA1zc2axfhcmaGq1P0lbDb_1kp2RkquAAyeELyYNtQSPa
 eh8.g2R.wltk0.F5NOis6gxmHNCElhCHMwgEXrcm20PTtLx7WwLmqoJ.fNyQZi7wVbicyv1jTXdY
 jWZr5ULqhyCy.9Gcs__n1kP.N8iMzYxQDgsDGuaVu4CWOCl8NdxdI1r_T09DSh91fvLjPuUtwBDo
 DXdFXj892.onGJJ8Xn1rdwOS7O9kUY74VarBQ1yqOlEdRHwPK1weBaLIH1SS4Fp6y9BnfDTgGdB_
 rb44y07RDIah2T0SQgupGn4E4zO3RuGzqcnbkn2WLxpF1qS8qOU5_bk6cb0dA9eFZzIey4sUyiZH
 PJKZP90X.CxUMyZWl14nblbt_sCM3lkPTMS3aMdewYYfOtrW3tcz2RnZe9ycxEM41MhfmEYTOqwe
 TYlESjoNHRzjhPKxDF6_yFaxAZSvB2RqHij46y.xOR7pKkvtVtXwlwFKAhMehEN_eCLc77Ctn_mF
 JWwcOA.BWZzr4.mUXNypn.POix_57XKqQ1IyrbkqhJkJMAs2AFt1IUWlJRIkdvuB_8L5i.S7RVwE
 bwR66_qLL3eJEILUpcXz7C4_rCSNSvWr2.KClSRLBe6O2h0SqbnaYjw9Zctexu9jlK62l2wgQZhp
 pZKPuBv20LcWIk8Rrx3eKsOon7dAJ25R7yJktWwbsITu80a5Gjks511MQkkKKzEcqjP_pR8956w6
 1UoQyIwrxCV17udE961IlJLCHS4Iddk3h74jng9jF5KKXUhUSFTpKtVdyC9m0xtF9j7RUkJUbuNt
 _1myRw4lcyDndEZJPbqWLHEivV1zPYGuACWhdZNy3nQLFI6PDANBDQfs3_0LnKMRyFjlJx9OnbvW
 q0W0Sd0LHWGNrgYGC8FU54XyVVT0N4EJbWctZ6ksqsG7DHceyIHm3ySIXH5gjnhAf2N81q0laZaR
 EaC_Mcsq0Ey5P7HIImzGuVZypK_p3glf1Bdfv1kenAchWc56zEP92Ut7GeoOT2rQzp4nXnqZPi9T
 Xl7TPcCec9f2aHbNAFhkUyCBUorcJ81EbswDjXFrFF3i7SqIRG7BfWUVyX.aZmahIWz.p74lFv.e
 b5SUAYAFm6oqns2pDPY4KOcxQk2IPpMzsVhrtOdsvxTUXTptcACq._ydnexEi0BO4Ez6i4E8dnNz
 gRnJH6CqPbjRUsotmlw09YNZY9Zye1WIUH8w_55uBIf1CJB1ueYPhu1fiMQzeQzwsVY8uleSTtTc
 25xqRO44XQl1m3FQ12xvw_iJgNqdPcMDgfJhkqyICMlBWt6sFUTaVG5llTMV5Vkm8Q6V0zbZktVQ
 8yx7TdIyVYpGLg5TO6Qr6nlKNlZ3t4wD129CLuDUC.pJXUe6FF4hosUc1haUbG8PWRiiQM32GnTL
 g_rJgHyIGckAZ17_5qNzSdWzTUDBv621_3O2Tai2n2RuiFqRpEfZKGEorYaORlOk407NtSscZSCa
 RTXv1SHomjMiZ6WmJFpvhyr0o_UYKWeo0htLhpa8yyaabYyNrfk0M6.L6qt1OzhfWgfo6_OtueBw
 8xgHS_n4et85hWGPUgk_ow8nSh3tCtzS4v6gftpWBSaUqDQfBUKRSWXUbeWIB80SZA7o8XDyqPiT
 oaNkMaYOwugl49Kp7.7EiasU7jOcDoTLzco0A8F4tFXCkr9Ij0qG63NZddgIHDNLdERHfc17_5VJ
 xqBfa6OZLjqH8bWBXNvGgK67rKYdo89iDU17niJ6M.1OhkZkfJxgL4.4c_fVvjtDRg4IqK.OBnQ9
 .82GPgPkK0fyi4Ct3mM.zCAxRTOu0gyZuRWQuzHvsp_.1rIF4YIF6MVpv7PKTtZllHvCmaGqF9Ta
 Lmd9ZzvS1ZZbUPbvIrizsKeoNo.OQVJoQRszfMdGzepNThl24E58n5F.ZspscZmdimdJ_18L3_cR
 kDqn1bi8aiY9LEmCrzPdcS_ou4lDRBgUZgqZ9vWPNGt2BDz0SXnNnhBofAUdSaNc3eRimRC27_D_
 yNJvy3gq4MD9t1dI7SLcMiJCObobiWkxnMU.F8Ow07X3jT9yGhXLlp.GVpK6VbajBqEjnA3X0HDU
 1XE_GzEmyH25YRwIoLNpfRN_xuK1yMeP0j5Z0qacqIUrwaFKcOEUebWPlpAbVN.1HKmTGAMoCtE5
 FB193AHJcGc3iEQPjfQ4BZlEjkJIZCzjb9Nx3uG27BW01ITjdU1UAvTFb4absB1.hnySzYNUx9p.
 yZA.NZvoaFA2SVnAC9qFZzj4UKbg_JpgLGg--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic309.consmr.mail.ne1.yahoo.com with HTTP; Mon, 28 Dec 2020 19:22:15 +0000
Received: by smtp408.mail.ne1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID a6826294e264b601a154bfa5fd362599;
          Mon, 28 Dec 2020 19:22:12 +0000 (UTC)
Subject: Re: [PATCH v23 02/23] LSM: Create and manage the lsmblob data
 structure.
To:     Mimi Zohar <zohar@linux.ibm.com>, casey.schaufler@intel.com,
        jmorris@namei.org, linux-security-module@vger.kernel.org,
        selinux@vger.kernel.org
Cc:     linux-audit@redhat.com, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        paul@paul-moore.com, sds@tycho.nsa.gov,
        linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
        Casey Schaufler <casey@schaufler-ca.com>
References: <20201120201507.11993-1-casey@schaufler-ca.com>
 <20201120201507.11993-3-casey@schaufler-ca.com>
 <903c37e9036d167958165ab700e646c1622a9c40.camel@linux.ibm.com>
From:   Casey Schaufler <casey@schaufler-ca.com>
Message-ID: <c88bc01f-3b65-f320-b42b-5ecde3e29448@schaufler-ca.com>
Date:   Mon, 28 Dec 2020 11:22:09 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <903c37e9036d167958165ab700e646c1622a9c40.camel@linux.ibm.com>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
X-Mailer: WebService/1.1.17278 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo Apache-HttpAsyncClient/4.1.4 (Java/11.0.8)
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 12/28/2020 9:54 AM, Mimi Zohar wrote:
> Hi Casey,
>
> On Fri, 2020-11-20 at 12:14 -0800, Casey Schaufler wrote:
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
> This patch is quite large, even without the audit rule change.  I would=

> limit this patch to the new lsm_id structure changes.  The audit rule
> change should be broken out as a separate patch so that the audit
> changes aren't hidden.

Breaking up the patch in any meaningful way would require
scaffolding code that is as extensive and invasive as the
final change. I can do that if you really need it, but it
won't be any easier to read.

> In addition, here are a few high level nits:
> - The (patch description) body of the explanation, line wrapped at 75
> columns, which will be copied to the permanent changelog to describe
> this patch. (Refer  Documentation/process/submitting-patches.rst.)

Will fix.

> - The brief kernel-doc descriptions should not have a trailing period. =

> Nor should kernel-doc variable definitions have a trailing period.=20
> Example(s) inline below.  (The existing kernel-doc is mostly correct.)

Will fix.

> - For some reason existing comments that span multiple lines aren't
> formatted properly.   In those cases, where there is another change,
> please fix the comment and function description.

Can you give an example? There are multiple comment styles
used in the various components.

> thanks,
>
> Mimi

I don't see any comments on the ima code changes. I really
don't want to spin a new patch set that does nothing but change
two periods in comments only to find out two months from now
that the code changes are completely borked. I really don't
want to go through the process of breaking up the patch that has
been widely Acked if there's no reason to expect it would require
significant work otherwise.

>
>> Acked-by: Stephen Smalley <sds@tycho.nsa.gov>
>> Acked-by: Paul Moore <paul@paul-moore.com>
>> Acked-by: John Johansen <john.johansen@canonical.com>
>> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
>> Cc: <bpf@vger.kernel.org>
>> Cc: linux-audit@redhat.com
>> Cc: linux-security-module@vger.kernel.org
>> Cc: selinux@vger.kernel.org
>> ---
>> diff --git a/include/linux/security.h b/include/linux/security.h
>> index bc2725491560..fdb6e95c98e8 100644
>> --- a/include/linux/security.h
>> +++ b/include/linux/security.h
>> @@ -132,6 +132,65 @@ enum lockdown_reason {
>>
>>  extern const char *const lockdown_reasons[LOCKDOWN_CONFIDENTIALITY_MA=
X+1];
>>
>> +/*
>> + * Data exported by the security modules
>> + *
>> + * Any LSM that provides secid or secctx based hooks must be included=
=2E
>> + */
>> +#define LSMBLOB_ENTRIES ( \
>> +	(IS_ENABLED(CONFIG_SECURITY_SELINUX) ? 1 : 0) + \
>> +	(IS_ENABLED(CONFIG_SECURITY_SMACK) ? 1 : 0) + \
>> +	(IS_ENABLED(CONFIG_SECURITY_APPARMOR) ? 1 : 0) + \
>> +	(IS_ENABLED(CONFIG_BPF_LSM) ? 1 : 0))
>> +
>> +struct lsmblob {
>> +	u32     secid[LSMBLOB_ENTRIES];
>> +};
>> +
>> +#define LSMBLOB_INVALID		-1	/* Not a valid LSM slot number */
>> +#define LSMBLOB_NEEDED		-2	/* Slot requested on initialization */
>> +#define LSMBLOB_NOT_NEEDED	-3	/* Slot not requested */
>> +
>> +/**
>> + * lsmblob_init - initialize an lsmblob structure.
> Only this kernel-doc brief description is suffixed with a period. =20
> Please remove.
>
>> + * @blob: Pointer to the data to initialize
>> + * @secid: The initial secid value
>> + *
>> + * Set all secid for all modules to the specified value.
>> + */
>> +static inline void lsmblob_init(struct lsmblob *blob, u32 secid)
>> +{
>> +	int i;
>> +
>> +	for (i =3D 0; i < LSMBLOB_ENTRIES; i++)
>> +		blob->secid[i] =3D secid;
>> +}
>> +
>> +/**
>> + * lsmblob_is_set - report if there is an value in the lsmblob
>> + * @blob: Pointer to the exported LSM data
>> + *
>> + * Returns true if there is a secid set, false otherwise
>> + */
>> +static inline bool lsmblob_is_set(struct lsmblob *blob)
>> +{
>> +	struct lsmblob empty =3D {};
>> +
>> +	return !!memcmp(blob, &empty, sizeof(*blob));
>> +}
>> +
>> +/**
>> + * lsmblob_equal - report if the two lsmblob's are equal
>> + * @bloba: Pointer to one LSM data
>> + * @blobb: Pointer to the other LSM data
>> + *
>> + * Returns true if all entries in the two are equal, false otherwise
>> + */
>> +static inline bool lsmblob_equal(struct lsmblob *bloba, struct lsmblo=
b *blobb)
>> +{
>> +	return !memcmp(bloba, blobb, sizeof(*bloba));
>> +}
>> +
>>  /* These functions are in security/commoncap.c */
>>  extern int cap_capable(const struct cred *cred, struct user_namespace=
 *ns,
>> diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/=
ima/ima_policy.c
>> index 9b5adeaa47fc..cd393aaa17d5 100644
>> --- a/security/integrity/ima/ima_policy.c
>> +++ b/security/integrity/ima/ima_policy.c
>>  	} lsm[MAX_LSM_RULES];
>> @@ -88,6 +88,22 @@ struct ima_rule_entry {
>>  	struct ima_template_desc *template;
>>  };
>>
>> +/**
>> + * ima_lsm_isset - Is a rule set for any of the active security modul=
es
>> + * @rules: The set of IMA rules to check.
> Nor do kernel-doc variable definitions have a trailing period.
>
>> + *
>> + * If a rule is set for any LSM return true, otherwise return false.
>> + */
>> +static inline bool ima_lsm_isset(void *rules[])
>> +{
>> +	int i;
>> +
>> +	for (i =3D 0; i < LSMBLOB_ENTRIES; i++)
>> +		if (rules[i])
>> +			return true;
>> +	return false;
>> +}
>> +
>>  /*
>>   * Without LSM specific knowledge, the default policy can only be
>>   * written in terms of .action, .func, .mask, .fsmagic, .uid, and .fo=
wner

