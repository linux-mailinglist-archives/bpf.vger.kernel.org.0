Return-Path: <bpf+bounces-17204-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 79B3280AACF
	for <lists+bpf@lfdr.de>; Fri,  8 Dec 2023 18:30:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9D9921C20AE6
	for <lists+bpf@lfdr.de>; Fri,  8 Dec 2023 17:30:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEF2239AF3;
	Fri,  8 Dec 2023 17:30:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="iGkseRuL"
X-Original-To: bpf@vger.kernel.org
Received: from sonic302-28.consmr.mail.ne1.yahoo.com (sonic302-28.consmr.mail.ne1.yahoo.com [66.163.186.154])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E252310CA
	for <bpf@vger.kernel.org>; Fri,  8 Dec 2023 09:30:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1702056634; bh=8zXEHe/Cw3PoTo1fEs/FubOVlk8pu/yyTJ13NPPN9Ec=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=iGkseRuLHj22MHvdhfafWbjRsCVo/ix0+Rb0oUFSxmWU89TSg2ElmDG5kzTDn8ThvhDfy2BAZ2hU6fZB5D404XErAbeUU3qbuZstm0XvHWyI2Cg/jrL8ME1UTmM+0EVvaY0mgeQd0nCHG+HMesE69noCvkyrnZhaAGrSq4AX6dlohDLcaQEMrqJw5gobZonzoIwxEvqtO3F69fiZR0cUK2rNLsK5mdzkvbHREKoYgXv4eb5Pr8UWVszbgxUfJqe7if9FKe/9FvoZXL8YCGnw/Hbcp4fYqJcAtIlJd0QaNWCP8ATKHMXC1WfERvy/njzxThKQJlZ8bKEwito/uUvVLA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1702056634; bh=EUu8V2DZAdffPTW9zidzI/UYmoOTb6yEguQkWsn+KZ2=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=AmNIfTJPozx3cM30zhfQOI+fc5upKFtwwB530L2Weea2/wq1X4k3RhbgcwMAZrxYCuxEI2gG7tWpRL0/+omiJSozlGK88TN2EHDSFn5ksqHTFQ+3M4BDBtLVzhnGrvOSUwqLGiuwOWBQhhyJabF4RqUgM/XDKQ5rldUtfp2yVC4mw6BGERazrts8/uMfpI2qCN6hqTT+oOB+NscNBdM2Olh4q5ap/wVuUeEMBFPr7disPLi3Y7H7cotDwFa0QOz4zVHndIZCSCQfOSLLdw2NG/QdHm0/DxMTG8R19Mi978b8YlbPVxNL82po+zb/E+WtFEBf2Azq712PqHxQVxHveA==
X-YMail-OSG: DmEwDnAVM1lE5G1CkPJRZChenw8a5EkT8bQ1P8PYulGMoKNe1U4ChrwBEi0wGm3
 CoHkvpVlITRVU2TVeID3wt_FkMlaOhKtnHsPXNSe_ws0ru7zng2j1n8rhvQNaJpHkFCAYn3_gR6b
 IKwjeTreEfYAd.6cI0UkqKJWt5inmTbAZXUcNcbmwTx88e92dK9KL6nutiZ0BDR8o3yx.qRUb7DM
 APD57SjALIJowUD1GMqXgOcOtlTZ8kwxJEAMdeLJK4IqyH6y_0xWmMIAvyWXEDiCMefTVau.uxhZ
 zJEOIkeYVOrtS_y0dOMUVKmygbORoW6UJxb1qTHQf9CU91DeGxRIAlTaVCmWsFwvhomyiVaYuFVJ
 O.LJro0zbIZRXXM7q9Jln_frS.7T10W1BKHeyZsat3IhGMsE9WAQbjXvFbwJFTx9jZmkRrlg4S3O
 ZaMk1lJpcIRW3c7pkqI5I.HgyB54PY4qoijMlwT7bAcuBjDiTK3tqyIHz895o1SDNEZJzt3Y9yLx
 od_wa2_HMkTjOy7eNEDxEm3N5MPXsCzHjmic.nKaxYNEajV1PoBU9RnTXgKx5xoh74rbAjRnwdJf
 mlnW1p3FetwgveB2ihqLN4whQ5RtH1m8JDIobzO9iidw8WqNmzTfQ9n7tqyfbZB6Z2KLZUgze2Tx
 T5weOSt7jjwVPEjqbSqq1WAsjW4o3Pxyn9BbwqgQnS6YPirjhjICStjnePm9KF_fN_ehoo.o55oQ
 MKKWn67kNYjEwGEjt9SEDTq6ly7m9BCvjcBZQliyJoMt1h7ld51h6mcLFnecdB.7auegWHoDGgwz
 Ymk8C7SL1OQ.Q6Uvt0kXy5hnssL0OO.DArzPQHo5pNegyD6SneU8Aw6htcWx_yTw3sqU7HsTrOdr
 WtQfnwgX38Lf2q7X9De40cCPSUsvNYr8CJ8QIWVnhAc7EwHYXeDn8alH0DWf_ux49RsY32YzDsvn
 MO6MJo3kX_6cIPhtTqrxjnA76YlB.KP43Om2csOMLk6TG75zDgEAxYfDwW.ICrsf26sm11ELJwWo
 mhlm7sW3BVxNC1OZSzWdTDmFb6uMJmnboN4QoK6Q6SmeVa9i9xE5AdG4WMNt2JBEeFV2yep4ud56
 lV5GPqUSqPXIu4DVmkDsdm.VQQ243DHA1mAE3JIeBUCDSqwaQRFcfTVaJ0pVoIVBukvCnVW.PkbU
 sJHZXlNZpap6Suw.dY2YZkJu50cV6SRuOwhgviWUwuK5MtFkDTTobmM54d29fEQSHQF5XJ.3RRne
 ZBoi6zuw4Bd47Q_QNuLXBrLbir7ZJKqgu6AOyGy51bhZmcvT8LRAWTMw75IdGTbgp.CFzEDqzCfF
 b17G8q5o2XhyMRBl_YRNUPhy88Abfc_CIdvF7lKYOtQu0TT2jtrVMktZiHBYiI6bpX83l3no3d6F
 IsolC_5kyLlrVQN3ZH7hHhJtkwAS1WOmv6kYAeJMvtbpDwdeyGfoUI_4BsxMjZ7Jj21xuwABSlFi
 XYURYaleDqD8t3ZqIU3vPgvMMGlkoicoCv6uEUQZZnPtwFAvmN7QGL2qiMBPbJIB.wq4je0yh9N1
 PSjbdGVUH_eGDb23UrIZXninP5oFitV8ZmwqCBRgbCDtxwyFvMlsp.ucwuesI.Qh5vzuGiXMM_GP
 wmAvPIAz.74dcdoie_vx0kAcp9XVmr308a8ekhgffNQ57mnTtjutuH1hRt3xo_l0VOAxzGjg0D6g
 ZlT_y_t3B3N4RpHSiCw0QBmEQ_DFkMca3KwUlUgK4GysSlgG_MuDleoMqzfI9bZs2ks48Ok0TE9w
 JAseF9uwWzINzj0OCiDK1bWYPHW2LEqkARot50zrJMjETz6gm1BwwRhzRkq.9ziVW8WhGC5tWH9V
 c467eN2.sQkFJ3ehMYwM7dqRpSuLu5VlBW4m5cqtzrh8wTsWMrB3qKfC9ssKX0NbS8DARXXoyG7V
 J.7FOEzXBY4U_xia.ntX6xP2WJ1U376FG06fGOi3NJeFf4nAL7OebNbqcWoROCFB4IAySZpRsCNl
 .jCMRpD9G6St4R3ePkceWRejShrrrye5_HzXTkIHZYaLqUsvsdtlSgMdislktbDRL.u.jdRqnUwy
 .JrnUZ9n9hQDClBWHoUGJ9QIzf9VZLUJrwxQb5Qru_MVjOD1g3wBE0VlLEl2H1oZO0xsBi.8zp0G
 NXTOUpD_cB8ddtUdWr9BzJrIAnu36kHKMGsuI38ih41cFwxFGyBrtU22E7e1b3llnbKBWsUINmAD
 3OnaleXePEt.4D87BOku1gfqE7vxjfCvPZx5s8VWjcm0LSNADq4Gn5omYaImU.jGLo_jHaMc3a8N
 DNQ4jCrKNkmwyUVgK
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: 3b43dc1b-0d77-4c6e-9a6d-f2561da61665
Received: from sonic.gate.mail.ne1.yahoo.com by sonic302.consmr.mail.ne1.yahoo.com with HTTP; Fri, 8 Dec 2023 17:30:34 +0000
Received: by hermes--production-gq1-64499dfdcc-msc64 (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 2122410847cde4919653afcb0e474ddf;
          Fri, 08 Dec 2023 17:30:30 +0000 (UTC)
Message-ID: <d049f5a1-29ac-4fd9-95b2-45d5fd5ecae5@schaufler-ca.com>
Date: Fri, 8 Dec 2023 09:30:29 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/5] mm, security: Add lsm hook for memory policy
 adjustment
Content-Language: en-US
To: Yafang Shao <laoar.shao@gmail.com>, akpm@linux-foundation.org,
 paul@paul-moore.com, jmorris@namei.org, serge@hallyn.com,
 omosnace@redhat.com, mhocko@suse.com, ying.huang@intel.com
Cc: linux-mm@kvack.org, linux-security-module@vger.kernel.org,
 bpf@vger.kernel.org, ligang.bdlg@bytedance.com,
 Casey Schaufler <casey@schaufler-ca.com>
References: <20231208090622.4309-1-laoar.shao@gmail.com>
 <20231208090622.4309-4-laoar.shao@gmail.com>
From: Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <20231208090622.4309-4-laoar.shao@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.21943 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

On 12/8/2023 1:06 AM, Yafang Shao wrote:
> In a containerized environment, independent memory binding by a user can
> lead to unexpected system issues or disrupt tasks being run by other users
> on the same server. If a user genuinely requires memory binding, we will
> allocate dedicated servers to them by leveraging kubelet deployment.
>
> At present, users have the capability to bind their memory to a specific
> node without explicit agreement or authorization from us. Consequently, a
> new LSM hook is introduced to mitigate this. This implementation allows us
> to exercise fine-grained control over memory policy adjustments within our
> container environment

I wonder if security_vm_enough_memory() ought to be reimplemented as
an option to security_set_mempolicy(). I'm not convinced either way,
but I can argue both. 

> Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> ---
>  include/linux/lsm_hook_defs.h |  3 +++
>  include/linux/security.h      |  9 +++++++++
>  mm/mempolicy.c                |  8 ++++++++
>  security/security.c           | 13 +++++++++++++
>  4 files changed, 33 insertions(+)
>
> diff --git a/include/linux/lsm_hook_defs.h b/include/linux/lsm_hook_defs.h
> index ff217a5..5580127 100644
> --- a/include/linux/lsm_hook_defs.h
> +++ b/include/linux/lsm_hook_defs.h
> @@ -419,3 +419,6 @@
>  LSM_HOOK(int, 0, uring_sqpoll, void)
>  LSM_HOOK(int, 0, uring_cmd, struct io_uring_cmd *ioucmd)
>  #endif /* CONFIG_IO_URING */
> +
> +LSM_HOOK(int, 0, set_mempolicy, unsigned long mode, unsigned short mode_flags,
> +	 nodemask_t *nmask, unsigned int flags)
> diff --git a/include/linux/security.h b/include/linux/security.h
> index 1d1df326..cc4a19a 100644
> --- a/include/linux/security.h
> +++ b/include/linux/security.h
> @@ -484,6 +484,8 @@ int security_setprocattr(const char *lsm, const char *name, void *value,
>  int security_inode_setsecctx(struct dentry *dentry, void *ctx, u32 ctxlen);
>  int security_inode_getsecctx(struct inode *inode, void **ctx, u32 *ctxlen);
>  int security_locked_down(enum lockdown_reason what);
> +int security_set_mempolicy(unsigned long mode, unsigned short mode_flags,
> +			   nodemask_t *nmask, unsigned int flags);
>  #else /* CONFIG_SECURITY */
>  
>  static inline int call_blocking_lsm_notifier(enum lsm_event event, void *data)
> @@ -1395,6 +1397,13 @@ static inline int security_locked_down(enum lockdown_reason what)
>  {
>  	return 0;
>  }
> +
> +static inline int
> +security_set_mempolicy(unsigned long mode, unsigned short mode_flags,
> +		       nodemask_t *nmask, unsigned int flags)
> +{
> +	return 0;
> +}
>  #endif	/* CONFIG_SECURITY */
>  
>  #if defined(CONFIG_SECURITY) && defined(CONFIG_WATCH_QUEUE)
> diff --git a/mm/mempolicy.c b/mm/mempolicy.c
> index 10a590e..9535d9e 100644
> --- a/mm/mempolicy.c
> +++ b/mm/mempolicy.c
> @@ -1483,6 +1483,10 @@ static long kernel_mbind(unsigned long start, unsigned long len,
>  	if (err)
>  		return err;
>  
> +	err = security_set_mempolicy(lmode, mode_flags, &nodes, flags);
> +	if (err)
> +		return err;
> +
>  	return do_mbind(start, len, lmode, mode_flags, &nodes, flags);
>  }
>  
> @@ -1577,6 +1581,10 @@ static long kernel_set_mempolicy(int mode, const unsigned long __user *nmask,
>  	if (err)
>  		return err;
>  
> +	err = security_set_mempolicy(lmode, mode_flags, &nodes, 0);
> +	if (err)
> +		return err;
> +
>  	return do_set_mempolicy(lmode, mode_flags, &nodes);
>  }
>  
> diff --git a/security/security.c b/security/security.c
> index dcb3e70..685ad79 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -5337,3 +5337,16 @@ int security_uring_cmd(struct io_uring_cmd *ioucmd)
>  	return call_int_hook(uring_cmd, 0, ioucmd);
>  }
>  #endif /* CONFIG_IO_URING */
> +
> +/**
> + * security_set_mempolicy() - Check if memory policy can be adjusted
> + * @mode: The memory policy mode to be set
> + * @mode_flags: optional mode flags
> + * @nmask: modemask to which the mode applies
> + * @flags: mode flags for mbind(2) only
> + */
> +int security_set_mempolicy(unsigned long mode, unsigned short mode_flags,
> +			   nodemask_t *nmask, unsigned int flags)
> +{
> +	return call_int_hook(set_mempolicy, 0, mode, mode_flags, nmask, flags);
> +}

