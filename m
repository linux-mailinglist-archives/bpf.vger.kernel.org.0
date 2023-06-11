Return-Path: <bpf+bounces-2348-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EEFB72B2EE
	for <lists+bpf@lfdr.de>; Sun, 11 Jun 2023 18:59:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D662E2810F5
	for <lists+bpf@lfdr.de>; Sun, 11 Jun 2023 16:59:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DEC1C8EB;
	Sun, 11 Jun 2023 16:59:22 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D36A3BE7C
	for <bpf@vger.kernel.org>; Sun, 11 Jun 2023 16:59:21 +0000 (UTC)
Received: from sonic311-30.consmr.mail.ne1.yahoo.com (sonic311-30.consmr.mail.ne1.yahoo.com [66.163.188.211])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66993E63
	for <bpf@vger.kernel.org>; Sun, 11 Jun 2023 09:59:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1686502758; bh=7DgmiJ22fK35rNDSjxBWlZUyMsVle3zhBPTayVRxagg=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=WlZvjTDlFW8Dge+gd1tlpy2eF6YGB8TV+StzVBR2hJE/BRtRxfyBmqKc3NKdxVPLKPyraFh73Y2lj7lUvActlXW4TCpUvpN/lJW2eQXM+eEn5zDzwFz+8YLBfpIwp07/SKJwsGJW/6j9q5jex6YhnQW7mpiCFFbbqecgV+pX/P0l4KoGUmOtkoMGXnJrNu8B6ktjwGpPu28V7W4PHKkSI98QhYOoyTywvvTLdPr3VqRbRXDKgfXOz1Pp/W9KBPFuF6YHkQWJW5ZCz4eDXGOZsaX01WbtQg0ZbW+eyD0wPaDDk0z+ou3xQgU5Kkmb+PTe2RrGIaxDejdEGhK3BWqifQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1686502758; bh=Bw/LP1AfuaenQ0zxwdibPZAH47OgxOVjpM6yDDmmHlq=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=kTuxdssiPuuJVLxUsysBhWHXN741iK7E6F/z6tAU0gbyw1PSQNP9NzU8vfUcpMalhyOKJnYxmoS5UEE2nLOsxVphsIWCfF7UsAJdGEgV/kV6Z47mw95tihV88imwQTPWXddRid3c0cUK6E6ZXf23i/XOKTVtxLdQmtxylRKiZXQaZWdZ0AYlIcS7yCuE5SplkvtJ9OLJPM/P6agxIDt6e+iKg+PtBPOou27TqCR1mZFXnCcP5Y344flZPXqylvQMH6KbtnLydXFU1gMAmwT7kniHHCfxmSHxniTdw5eVxnhw6Z9penxfUzAf3qZbKnY51avh7pHBF1mqFG4vfrieHQ==
X-YMail-OSG: L.q6DH0VM1msMV_aMf1IXTl60njTH76ZX6CVdR2rTZWI.fi02qwrRdqY7t4QlR1
 ybQ2_iK3wO4D7UWTz.N5phjZ1HItKaFA6hQxTQd5vdxSBpNG5FROpV3WHLRlTKqtfMabF_39zYTP
 QgINTZG2KsTjYcimAEHM7sdYT1LkXPIFH9uYOINBTz6h1mp8GwCcpr6Yz3Ou8MlTyrTH10f.AJ1y
 uy.BcA4UMZyePvzlu09foH1.XFr5Cd0Anm7nSYRbUMNQtq7LZa143YVnAuO6CEPOYJZtvj4jNifk
 xjHEDj2xA.2EJEguY5A2uvdewg9VGWVuthJkASGb.491SebqIZeXQSESaC8Ntw0JX1gITJLAyRZI
 J9edhZFO6mKVqtuMA3Tu1zv9KW.3Q4dQbi1R3bZx2KzsqciOF0h5ewwjN93CaNMtMpGSSx3tqM8V
 g9P6_pcxbayv8AmKpfzi_X_ls9YxsNCJ7GiO5mrWFCWRJVHxLbZ.Qz35YWnOMP6gX85sd1KfEDxz
 CmWDsffx.OuoVX_LWN1A2.5ZVqqu0soMrcRYg8nwyX8Gweg2_qIfnf6K8p8B3kemuyRLEZg6wjO3
 8lQEaNe.VFNFz0MfgKzGy_fw7Ty.p64yGxFLaozv_EoJZiUbqjqHY3zwOB6uGe5jh.p.BQ2ai1n.
 8eATLaZUNlhZVg95JMSe.rq.ZxLw0lcjt.SZI0HlPhHP198M6i4t4a_x6HJUjYPlWk.LpykgtQ52
 3Cg0QiipDh3ECZizT7EeRiIxO9IJGFDrYIuVLXm.fyU2JKH8oJEB.QTFSsR3bufCa8OanuJEyua4
 ozEvxi6lUR0q1OnSeqFxIXU8zDbzBxm5grFrX3K4W7skzTeQHiOAy0eA0Wyoz7GfC7tddedtjuPi
 shJNBR_fZRNnk0bhVAKC7Puk7GCfOUl0sv8TyRAXYNf0MVR2mFmVlKE9p95tKtWNC4TqHbq66X27
 gXeuZuHRxPjRFrdmV0ceaVLtKFBzHkDRBOxmKCfMaQ_XBMByq2SWnoBYdK2uwuBCklqdi9A8e0Nb
 NUBsD7nrTZNlWaSvioq2uhfSndGvjKa4pa1.SfHjhxSXgKRlg2mqvZmQj2mvhGdPjZ2Kp2zg24Oq
 igHS8ZmstUvCvHWhjSta3Vc5kuGCs0mMD8ZAl0EWFYtaf02L819JZVPA02Bt33yUhlhgM7jTl2vK
 0X_GVLKGxgYygpzEMDu.fHnN8fCxXFjQwr.2g61uKWE6EPXXmWANWI0NUXJmw8f0599yLmjgiCXJ
 .pvZFSrbyVPtwkMvEehaQnel2YHSguKIBn0kLbw0u7VXNjREKPva.vNxm1DBwZqFnm8ubTZSDO0n
 53W2H8jQLOf8iqJlizrVE9HYomUx4AiPFEfHdXEHgkW23adrFoa0OcjX5JF_49FFm.np4Y3G9EW8
 OVfafyn0Yt45XcAo.uP7VpykJ.vo98IAd29SQzhlu0AzL79UApfkBA8tU1nMRX9WCrV8tMfAB.V.
 N29FFQoICyOLudadxWbaWZMvTOZqkfWDBGemHZ8mKo0d3Op7hql_kO8NxoacA80zeS9mANQap5id
 Husp6EjloTOB0krz8oUaoFL55AcQ_T4A58LTqx4nWMjXRKFD4iIvFX70RWLL8Agv4KXo7DSDMYt6
 D3rRJo_W3vCgt__nWkDPl9lvVNQh4B3VxB3hDa4tZadUilbaAfC6n5tNw0Y3GVig8uv8fQ7OQ3aB
 561Jd90WctFNC1xjCzj34Q6Qvq9enQlmIOEnQC.ITxD68OkWImZ7ii_dysHEbaD.KM3wyJRKhJri
 3sRhW6Zig0jRJ9y9azhr5CuT8KDN8ntRAJ8RXc3x0nlzvzFUNQN6NQG4ANRfzxLeQsNJ66HGgIqu
 fKRcfA8J0mFm4bPecTytSWc1mbQszd11iGx5gGqPgpSllh9drLBoJVxSDnSAe65_azhz3vePzl6L
 tU0eR6CqMv.mxjfV_PSO_nfXdHH6BcXa9rKv4K1AhBftf0wF9_CSEJT5eMXu6XoqE6hj1abYgc0o
 Rrw9SMzMF6l4g7IcTZprTG_ZweRiQWXBlLXcDIO9QxlKEJSK4P8RpYt3jZufHF_U5vJkYf5fRB3u
 arKsV2E3TQ8LPAmzQ9MAe75VlJBmMCoHXGlsMIK_vUAEZ5zaF8C6OhYBQGtyIRG4UErIn1iTYAgv
 _NXhUUjpdRSWdp9OIYNXiUuk4mhkvhcl2JsCibzONAT7lbHYl5cgIYsZl90BV8TcDLOocgDaagMJ
 yuJIUc_DfXEcLGKqL.BleUPUT3gSzMEdR4j6pPoqjl0GuSTtkQ3uLTSRdVvklNK3yFbNf_L9l9BU
 O2zuT.3LXlq2.sw--
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: 3d22b0d8-f4f9-4c6a-a046-6dd8537797e8
Received: from sonic.gate.mail.ne1.yahoo.com by sonic311.consmr.mail.ne1.yahoo.com with HTTP; Sun, 11 Jun 2023 16:59:18 +0000
Received: by hermes--production-ne1-574d4b7954-xz2cn (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 73c567dd6e3213e09855c459a66d5812;
          Sun, 11 Jun 2023 16:59:16 +0000 (UTC)
Message-ID: <c8dcb3b7-33ab-5ecc-ef11-0c42cd792934@schaufler-ca.com>
Date: Sun, 11 Jun 2023 09:59:14 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v12 2/4] smack: Set the SMACK64TRANSMUTE xattr in
 smack_inode_init_security()
Content-Language: en-US
To: Roberto Sassu <roberto.sassu@huaweicloud.com>, zohar@linux.ibm.com,
 dmitry.kasatkin@gmail.com, paul@paul-moore.com, jmorris@namei.org,
 serge@hallyn.com, stephen.smalley.work@gmail.com, eparis@parisplace.org
Cc: linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org,
 linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
 bpf@vger.kernel.org, kpsingh@kernel.org, keescook@chromium.org,
 nicolas.bouchinet@clip-os.org, Roberto Sassu <roberto.sassu@huawei.com>,
 Casey Schaufler <casey@schaufler-ca.com>
References: <20230610075738.3273764-1-roberto.sassu@huaweicloud.com>
 <20230610075738.3273764-3-roberto.sassu@huaweicloud.com>
From: Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <20230610075738.3273764-3-roberto.sassu@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.21516 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
	SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 6/10/2023 12:57 AM, Roberto Sassu wrote:
> From: Roberto Sassu <roberto.sassu@huawei.com>
>
> With the newly added ability of LSMs to supply multiple xattrs, set
> SMACK64TRASMUTE in smack_inode_init_security(), instead of d_instantiate().
> Do it by incrementing SMACK_INODE_INIT_XATTRS to 2 and by calling
> lsm_get_xattr_slot() a second time, if the transmuting conditions are met.
>
> The LSM infrastructure passes all xattrs provided by LSMs to the
> filesystems through the initxattrs() callback, so that filesystems can
> store xattrs in the disk.
>
> After the change, the SMK_INODE_TRANSMUTE inode flag is always set by
> d_instantiate() after fetching SMACK64TRANSMUTE from the disk. Before it
> was done by smack_inode_post_setxattr() as result of the __vfs_setxattr()
> call.
>
> Removing __vfs_setxattr() also prevents invalidating the EVM HMAC, by
> adding a new xattr without checking and updating the existing HMAC.
>
> Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>

Reviewed-by: Casey Schaufler <casey@schaufler-ca.com>

> ---
>  security/smack/smack.h     |  2 +-
>  security/smack/smack_lsm.c | 45 ++++++++++++++++++++++++--------------
>  2 files changed, 29 insertions(+), 18 deletions(-)
>
> diff --git a/security/smack/smack.h b/security/smack/smack.h
> index aa15ff56ed6..041688e5a77 100644
> --- a/security/smack/smack.h
> +++ b/security/smack/smack.h
> @@ -128,7 +128,7 @@ struct task_smack {
>  
>  #define	SMK_INODE_INSTANT	0x01	/* inode is instantiated */
>  #define	SMK_INODE_TRANSMUTE	0x02	/* directory is transmuting */
> -#define	SMK_INODE_CHANGED	0x04	/* smack was transmuted */
> +#define	SMK_INODE_CHANGED	0x04	/* smack was transmuted (unused) */
>  #define	SMK_INODE_IMPURE	0x08	/* involved in an impure transaction */
>  
>  /*
> diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
> index 25ade3819af..679156601a1 100644
> --- a/security/smack/smack_lsm.c
> +++ b/security/smack/smack_lsm.c
> @@ -52,7 +52,14 @@
>  #define SMK_RECEIVING	1
>  #define SMK_SENDING	2
>  
> -#define SMACK_INODE_INIT_XATTRS 1
> +/*
> + * Smack uses multiple xattrs.
> + * SMACK64 - for access control,
> + * SMACK64TRANSMUTE - label initialization,
> + * Not saved on files - SMACK64IPIN and SMACK64IPOUT,
> + * Must be set explicitly - SMACK64EXEC and SMACK64MMAP
> + */
> +#define SMACK_INODE_INIT_XATTRS 2
>  
>  #ifdef SMACK_IPV6_PORT_LABELING
>  static DEFINE_MUTEX(smack_ipv6_lock);
> @@ -935,7 +942,6 @@ static int smack_inode_init_security(struct inode *inode, struct inode *dir,
>  				     struct xattr *xattrs, int *xattr_count)
>  {
>  	struct task_smack *tsp = smack_cred(current_cred());
> -	struct inode_smack *issp = smack_inode(inode);
>  	struct smack_known *skp = smk_of_task(tsp);
>  	struct smack_known *isp = smk_of_inode(inode);
>  	struct smack_known *dsp = smk_of_inode(dir);
> @@ -963,6 +969,8 @@ static int smack_inode_init_security(struct inode *inode, struct inode *dir,
>  		if ((tsp->smk_task == tsp->smk_transmuted) ||
>  		    (may > 0 && ((may & MAY_TRANSMUTE) != 0) &&
>  		     smk_inode_transmutable(dir))) {
> +			struct xattr *xattr_transmute;
> +
>  			/*
>  			 * The caller of smack_dentry_create_files_as()
>  			 * should have overridden the current cred, so the
> @@ -971,7 +979,18 @@ static int smack_inode_init_security(struct inode *inode, struct inode *dir,
>  			 */
>  			if (tsp->smk_task != tsp->smk_transmuted)
>  				isp = dsp;
> -			issp->smk_flags |= SMK_INODE_CHANGED;
> +			xattr_transmute = lsm_get_xattr_slot(xattrs,
> +							     xattr_count);
> +			if (xattr_transmute) {
> +				xattr_transmute->value = kmemdup(TRANS_TRUE,
> +								 TRANS_TRUE_SIZE,
> +								 GFP_NOFS);
> +				if (!xattr_transmute->value)
> +					return -ENOMEM;
> +
> +				xattr_transmute->value_len = TRANS_TRUE_SIZE;
> +				xattr_transmute->name = XATTR_SMACK_TRANSMUTE;
> +			}
>  		}
>  
>  		xattr->value = kstrdup(isp->smk_known, GFP_NOFS);
> @@ -3518,20 +3537,12 @@ static void smack_d_instantiate(struct dentry *opt_dentry, struct inode *inode)
>  			 * If there is a transmute attribute on the
>  			 * directory mark the inode.
>  			 */
> -			if (isp->smk_flags & SMK_INODE_CHANGED) {
> -				isp->smk_flags &= ~SMK_INODE_CHANGED;
> -				rc = __vfs_setxattr(&nop_mnt_idmap, dp, inode,
> -					XATTR_NAME_SMACKTRANSMUTE,
> -					TRANS_TRUE, TRANS_TRUE_SIZE,
> -					0);
> -			} else {
> -				rc = __vfs_getxattr(dp, inode,
> -					XATTR_NAME_SMACKTRANSMUTE, trattr,
> -					TRANS_TRUE_SIZE);
> -				if (rc >= 0 && strncmp(trattr, TRANS_TRUE,
> -						       TRANS_TRUE_SIZE) != 0)
> -					rc = -EINVAL;
> -			}
> +			rc = __vfs_getxattr(dp, inode,
> +					    XATTR_NAME_SMACKTRANSMUTE, trattr,
> +					    TRANS_TRUE_SIZE);
> +			if (rc >= 0 && strncmp(trattr, TRANS_TRUE,
> +					       TRANS_TRUE_SIZE) != 0)
> +				rc = -EINVAL;
>  			if (rc >= 0)
>  				transflag = SMK_INODE_TRANSMUTE;
>  		}

