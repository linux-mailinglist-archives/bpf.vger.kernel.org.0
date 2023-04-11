Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 928746DE333
	for <lists+bpf@lfdr.de>; Tue, 11 Apr 2023 19:54:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229822AbjDKRyh (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 11 Apr 2023 13:54:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229752AbjDKRyg (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 11 Apr 2023 13:54:36 -0400
Received: from sonic305-27.consmr.mail.ne1.yahoo.com (sonic305-27.consmr.mail.ne1.yahoo.com [66.163.185.153])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDC044EEE
        for <bpf@vger.kernel.org>; Tue, 11 Apr 2023 10:54:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1681235674; bh=fGQ/Q7TktUdbrwtcs4d+zlOk6EJlzv1LPbuaeOzMpN0=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=RZa3olJISDTIAcn27+5P2WNEtQLN24G+D4etMjfeXY0CVW+6EyIgH5CauYVYJsvziedUobL5W/LX0TQnBWKUhrNjlpbC/zln5jul0jUKlbvd6PV+ARPqr0yAZyUHbzNNcjghHUN0U7a4+gA16cJklFwC3YLFn8V6sI2gK9Yl5GJwB10cFrg2sUKOo2nZ929NXFNowJ5ClBGyAU2LYyHlYD6ZqOpBmTlT0C7bB/nam/IvqrFHb0BZIfFL8eMjrWbCqYTD+op9z6rQ2xbmItj0s2Qm2/vVoz8p9N2Wn8lbJ2QMQgGc0VnxbGjK1EImhreA3qWp1WRHVFImZrHvMvUZ8A==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1681235674; bh=VcM0X6briIK3L2IQ2g0juE33a63sDXI7Nt5D2tthqkw=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=PIikRrFgXhJeWcbAiYI4oWSlE/gJKAHvUlUh9pHHx1RfbMAHBZlUS988bXfJEBzen71/Lc4Cw9GP4c1q159txHjllReUsVURqPlOUtyrvuec6FD9Hfkb8O5joqFhBHe5TnrrVElbhpRRy6Qb4b0n4hV+pvVhsqylQv8YuzvdYRJ9mKJhAqbORBIljQXNo9SmCfYdv00VeHXydvxkgqIlMLlExwi/0dirak/oKfSYvZ+RfO5LPN4jiAVkixfX8a6/ZL6lMGTvS/8sF7sqxlzKUt5WICXPVoaJ1cwKELtA61IgvRq1mpH7yX8RXteWLyebyraBHlSabDqpq0hOi/dJhg==
X-YMail-OSG: ex4xgrIVM1mq_GFAgmdkgns_DXkZUMCYSJARXKpMe0nJZcLBAjwOapPg1Tk6Q6s
 c3GC8GsN977ZKnlJLEVpaZDIrRuthATLHdJUsBtU0eRIEeW8kQv0Iqn.4nTiKHCNv4bJ98_Ru.E5
 s_1q3TGYmyCb2NstdjI3TeddkBNYIErWV1eh27CETeryV2i25gGhYCIaH7Gjh0eB5q4PHlTUE7OL
 6ZjHqKWpoRCTU091eRPbhkkWB8c5HmKeVtcyISf8tIviZ5cftHFpwEZFqldYqh9vRMrSqxXP8X3v
 Oikl2Ut2adVZH66Tn9v3B_DUD_LCuTd6J3HldYymMFCIexxQCjAn21XlgvJdxxQrieMj.iI8n71X
 hsc7svA9t1iUD9rpXFuGKgnv.9lCsTB4RkPs0TdSe.wbW0dcNhVBJ_qgplhFiarzdWK5_VqeKlIv
 yJ5mgF9POtwliMALpHVfiol_KuIVbzHFSqrOQuCt.6DRW5Wqmh6v3b67AcYMOXYk6DsaQ.G8OP8h
 PBLfUyxm8xtw2QB8WWAwS3V7pZzJPZxqZCkJYEP1g_061tRIPrDb7JrasSZSbI_6pI813UKH0IrC
 zkNzDLvcb9m4ogbwjtVs_9Lf8wVRpxUZ4mdplJheovcATXrV41tln3j2cW576inegQ8zK3VSlSh7
 LDlzE3oiaqesSoZGk_NSrda1eCBk.GkvdpLrPGhHxSgSdJ0fJXezf.bkqPV82yJld6hMULDenj9a
 uoevL1_ZMSIquUWcUztvc3HzDfLzUayBwmyIzD4YAHt8wain6hIss6DyHSmQ4YTa72KoFLiN0VZV
 IuiLkzwWgyvgFJQrtUo2wKGpE2BDj.B18CIi7gHSSVC4o2nS5lzAUTdYVYCmioZqsVpiMxSfHv9I
 C7YWagQRI33VNvYnPkQPT0KFj5Thg1RHDxeufEVz9f0AVazrEUXccbz8776guAbHAfqhI9ok_thf
 uw4FbL6QIT7ZwYziVka_K71DBpZjHAyZwLxBM9qiThF3nAKuEh3FAh5erl0DFyHumqm9ZhGJKQOl
 NRpki1e0WDd3z56m8Xdl2P.wwakxy52cAH8cxXVANXAub3GRZew75R8eu4hG_KxLUQk5lHf9qZX8
 QC6oECgWZ4_Q5sfLrM63wJs9dh8USVmP_TcuQfkzN38VwaDi1sfOrowYBwCr6INntMIWY54jsOMc
 2siRhaQFN6fe1eKuzx50Wdp7_nB53Kyjv8jDfGIsXrayxtb.u07N9B4SjAtWrEkGA6C3Pw5bdJYi
 8anqhGoOxlcO8MF31J5azLQ8jc3DIawpk3MWC.rB1CgGtY94UQPtROLwvMi0Sey65zLNIOXYkakq
 Ty4sKexVI48.JykFo9LJb6fntZfGNJzEKjZ9pL.wow2aPqU61SNypURvgNVa.eXZL_.2DXfmEuUs
 SsiuP.jfyu41s_aUhRaAFGSVUSBMtloXGU9y2plMlMa.33pwMsVDstR5eV7vcUfFnFvT.zaRiqb3
 qMCFvTTKkXxqNCOW8eBlD.t7CB9BX2LDmZNVHVkC2BHWbER_2dYpHOhJ93EQ28nsDCk6S1v3c11x
 2PP5c.ZGVN7gGtcWzb2AKHLH0lGimm5cBawx9NLl6BccNf1HZFC55FG88PVuSepPyNpMNWa6iWVF
 7LRmhtI8QadEQXyQsvBJjGVfIizM7WLVbRAEYqUjxzsCsdVX79Vbgxu3tkETufEY867KjL7qktTL
 fCuvaDVVg5WnYfSAXJ7vYy8FEKB6UmU8Eu20D8KMOt5DHp5GFuV4EKfnGKCkOFQ4uxfyIzFuMbvV
 bqbEKa2OQMlbp7GiKY8EXUTUddXttUeVZ2r9UIcicOgNOlGZUUJKTOqpWBwBUPh56aoS.NXmAgIp
 y6U760J9xfZkrSBVlaYjuAdHwVdioqt65dzRdblS63m6ggxHhflPyAyY7d_DBxkABroW8KAcMhyv
 1wQRXQKXhq3egvNf08kRdfjXAom3SC9wXHf0lUegrkzmxVfBcv6xo9Y9qCOAdUv8Lrm1H.3TRY9z
 NgEOM0_jx.LtOtJQC6q4Y.SYJgt0CDSRfNCMCkZ0HrmzDYfliox3RCWPfYCYocpqyTwwFoA1_JEO
 ewX9PZMXYqP.5TnAR9ZxwcxYDNcqKq_sx2TJVtfRpElAKK209SJSKqLJ_Gj2dXwm5TlJeGhCCYAt
 F3o1tY05LRYUrRyQmUgzrMu58PaH52c9AJh3v9yKQa13_TvoV9vlLLbc3YyXiE78EQUtK3EgQhx6
 D7ABlvnOTKnRhvRnE1b8XXSmU15MaGow27I9nyEapm6bKSmBkrm4kdxe3zUw6ousf2Uqa6hJEMIT
 XqpkI01Dae_p7XeG0_hx1FVMLdg--
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: bb284cfe-0ef5-4431-9d01-cc72aa119f74
Received: from sonic.gate.mail.ne1.yahoo.com by sonic305.consmr.mail.ne1.yahoo.com with HTTP; Tue, 11 Apr 2023 17:54:34 +0000
Received: by hermes--production-ne1-7dbd98dd99-tcjjg (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 3f38cbf819fe34d180ae475167ff757d;
          Tue, 11 Apr 2023 17:54:32 +0000 (UTC)
Message-ID: <2dc6486f-ce9b-f171-14fe-48a90386e1b7@schaufler-ca.com>
Date:   Tue, 11 Apr 2023 10:54:30 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH] Smack modifications for: security: Allow all LSMs to
 provide xattrs for inode_init_security hook
Content-Language: en-US
To:     Roberto Sassu <roberto.sassu@huaweicloud.com>, zohar@linux.ibm.com,
        dmitry.kasatkin@gmail.com, paul@paul-moore.com, jmorris@namei.org,
        serge@hallyn.com, stephen.smalley.work@gmail.com,
        eparis@parisplace.org
Cc:     reiserfs-devel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        bpf@vger.kernel.org, kpsingh@kernel.org, keescook@chromium.org,
        nicolas.bouchinet@clip-os.org,
        Roberto Sassu <roberto.sassu@huawei.com>,
        Casey Schaufler <casey@schaufler-ca.com>
References: <c7f38789-fe47-8289-e73a-4d07fbaf791d@schaufler-ca.com>
 <20230411172337.340518-1-roberto.sassu@huaweicloud.com>
From:   Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <20230411172337.340518-1-roberto.sassu@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.21365 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo
X-Spam-Status: No, score=-2.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 4/11/2023 10:23 AM, Roberto Sassu wrote:
> From: Roberto Sassu <roberto.sassu@huawei.com>
>
> Very very quick modification. Not tested.
>
> Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> ---
>  security/smack/smack.h     |  2 +-
>  security/smack/smack_lsm.c | 42 ++++++++++++++++++++------------------
>  2 files changed, 23 insertions(+), 21 deletions(-)
>
> diff --git a/security/smack/smack.h b/security/smack/smack.h
> index e2239be7bd6..f00c8498c60 100644
> --- a/security/smack/smack.h
> +++ b/security/smack/smack.h
> @@ -127,7 +127,7 @@ struct task_smack {
>  
>  #define	SMK_INODE_INSTANT	0x01	/* inode is instantiated */
>  #define	SMK_INODE_TRANSMUTE	0x02	/* directory is transmuting */
> -#define	SMK_INODE_CHANGED	0x04	/* smack was transmuted */
> +#define	SMK_INODE_CHANGED	0x04	/* smack was transmuted (unused) */

See below ...

>  #define	SMK_INODE_IMPURE	0x08	/* involved in an impure transaction */
>  
>  /*
> diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
> index 8392983334b..b43820bdbd0 100644
> --- a/security/smack/smack_lsm.c
> +++ b/security/smack/smack_lsm.c
> @@ -54,12 +54,12 @@
>  
>  /*
>   * Smack uses multiple xattrs.
> - * SMACK64 - for access control, SMACK64EXEC - label for the program,
> - * SMACK64MMAP - controls library loading,
> + * SMACK64 - for access control,
>   * SMACK64TRANSMUTE - label initialization,
> - * Not saved on files - SMACK64IPIN and SMACK64IPOUT
> + * Not saved on files - SMACK64IPIN and SMACK64IPOUT,
> + * Must be set explicitly - SMACK64EXEC and SMACK64MMAP
>   */
> -#define SMACK_INODE_INIT_XATTRS 4
> +#define SMACK_INODE_INIT_XATTRS 2
>  
>  #ifdef SMACK_IPV6_PORT_LABELING
>  static DEFINE_MUTEX(smack_ipv6_lock);
> @@ -957,11 +957,11 @@ static int smack_inode_init_security(struct inode *inode, struct inode *dir,
>  				     const struct qstr *qstr,
>  				     struct xattr *xattrs, int *xattr_count)
>  {
> -	struct inode_smack *issp = smack_inode(inode);
>  	struct smack_known *skp = smk_of_current();
>  	struct smack_known *isp = smk_of_inode(inode);
>  	struct smack_known *dsp = smk_of_inode(dir);
>  	struct xattr *xattr = lsm_get_xattr_slot(xattrs, xattr_count);
> +	struct xattr *xattr2;

I'm going to channel Paul and suggest this be xattr_transmute instead of xattr2.
It also looks like it could move to be declared in the if clause.

>  	int may;
>  
>  	if (xattr) {
> @@ -979,7 +979,17 @@ static int smack_inode_init_security(struct inode *inode, struct inode *dir,
>  		if (may > 0 && ((may & MAY_TRANSMUTE) != 0) &&
>  		    smk_inode_transmutable(dir)) {
>  			isp = dsp;
> -			issp->smk_flags |= SMK_INODE_CHANGED;

I think you need to keep this. More below.

> +			xattr2 = lsm_get_xattr_slot(xattrs, xattr_count);
> +			if (xattr2) {
> +				xattr2->value = kmemdup(TRANS_TRUE,
> +							TRANS_TRUE_SIZE,
> +							GFP_NOFS);
> +				if (xattr2->value == NULL)
> +					return -ENOMEM;
> +
> +				xattr2->value_len = TRANS_TRUE_SIZE;
> +				xattr2->name = XATTR_NAME_SMACKTRANSMUTE;
> +			}
>  		}
>  
>  		xattr->value = kstrdup(isp->smk_known, GFP_NOFS);
> @@ -3512,20 +3522,12 @@ static void smack_d_instantiate(struct dentry *opt_dentry, struct inode *inode)
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

Where is the SMACK64_TRANSMUTE attribute going to get set on the file?
It's not going to get set in smack_init_inode_security(). The inode will
know it's transmuting, but it won't get to disk without the __vfs_setxattr()
here in smack_d_instantiate(). Now, it's been a long time since that code
was written, so I could be wrong, but I'm pretty sure about that.

I think that you should be fine with the changes in smack_init_inode_security(),
and leaving smack_d_instantiate() untouched. 

>  			if (rc >= 0)
>  				transflag = SMK_INODE_TRANSMUTE;
>  		}
