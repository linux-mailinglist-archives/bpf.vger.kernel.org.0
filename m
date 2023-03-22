Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B15F6C3EE5
	for <lists+bpf@lfdr.de>; Wed, 22 Mar 2023 01:00:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229464AbjCVAAh (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 21 Mar 2023 20:00:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjCVAAg (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 21 Mar 2023 20:00:36 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 714B01C7E7
        for <bpf@vger.kernel.org>; Tue, 21 Mar 2023 17:00:35 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id o2so10348603plg.4
        for <bpf@vger.kernel.org>; Tue, 21 Mar 2023 17:00:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1679443235;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OlL5Bq/8UfJJKh8uObMBtLoyDQEvfbDlcdXWpMvzI5k=;
        b=PdRWUSN0XOSfJkGNjDPcSbu8qjn/DEplnCRbJ3asDnfKSQPhXeTlbCr5dtDb3vTV6I
         OH5FmWjEhRoYDwoDfXzX7j7GJRYEtkF5FDrrpvWkqh8SWZF9ulGclBcPaL2E5sLKiuVa
         LalItF3KZG24WMY97KcoJL8M/0sN6bc/eUQC3JtLB8ZbJ1ExgapeI7IrK8X3uKA8UqEj
         zAiO+7Z04ILDxfbiVXRb5PPh8Yt86g4mCN0stP8aGKVqK7V/Mp6/GQ1gILrdUtO0zIIO
         7lzPkHjBGibTXO/XMu27s4xczjVu9BSL5JBvb/kjRKeQtgHFzqxAVbEclEjZqlHzMdx2
         WJRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679443235;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OlL5Bq/8UfJJKh8uObMBtLoyDQEvfbDlcdXWpMvzI5k=;
        b=sbuv1oDqgeS7yMWWz3nF5kmeyPROeK2tFDZIshAoTYoV3JoVmJEvZySOfzyzCAu5bh
         lWCCZvXkPiAQaMN9XvCbp5u41jF6kGodEi6sMANvSgsztwxYKTp1GkjiPn5+L6ZOQSlG
         uftPxv3NnlM3eligZgU3KuLnBUqVOpJ71iTB3n1l2h0L7cRa8IF25Ge2McnX0jbFK2tz
         w4kSUI53HaRSAb7GK8OPH5EGY7dsBGwtSsn46FGIzQVieI8uh4WMNr1SzAU2FSfxwYRa
         lMQJXVGtFSOt1sbTAKU6Q15/EMwFa2GF+XhKoM+mBt+pfQIJwk0xs8N4ySulPMu/2Zvv
         PcYQ==
X-Gm-Message-State: AO0yUKWUV6Oiz58+JRFDBXgeOLX/ORhBfYJKdKaO4WPGO3iL0elgxSwd
        7P5i/NUy4KTWAQ8sh4CmkyF9vugFtMcxy2TBt1s=
X-Google-Smtp-Source: AK7set+1vbGe/9Y1D1jrNyHPWRr4u2vdHU9IdzeU2r5rKBPys3eqlpgEzAlFBrI9ewW/Y2bJqiBS+Q==
X-Received: by 2002:a17:90b:17d2:b0:22c:816e:d67d with SMTP id me18-20020a17090b17d200b0022c816ed67dmr1557306pjb.24.1679443234826;
        Tue, 21 Mar 2023 17:00:34 -0700 (PDT)
Received: from ?IPv6:2607:fb90:27d2:7ec9:b95c:972f:4df2:a852? ([2607:fb90:27d2:7ec9:b95c:972f:4df2:a852])
        by smtp.gmail.com with ESMTPSA id c12-20020a170902848c00b0019e30e3068bsm9300282plo.168.2023.03.21.17.00.33
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 21 Mar 2023 17:00:34 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.7\))
Subject: Re: [PATCH v3 bpf-next 2/5] bpf: Add bpf_sock_destroy kfunc
From:   Aditi Ghag <aditi.ghag@isovalent.com>
In-Reply-To: <aa458066-529f-cb84-ce4e-2c780aad17bf@linux.dev>
Date:   Tue, 21 Mar 2023 17:00:32 -0700
Cc:     kafai@fb.com, Stanislav Fomichev <sdf@google.com>,
        edumazet@google.com, bpf@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <181130C0-6EC6-49EB-BF16-DC23F36AF254@isovalent.com>
References: <20230321184541.1857363-1-aditi.ghag@isovalent.com>
 <20230321184541.1857363-3-aditi.ghag@isovalent.com>
 <aa458066-529f-cb84-ce4e-2c780aad17bf@linux.dev>
To:     Martin KaFai Lau <martin.lau@linux.dev>
X-Mailer: Apple Mail (2.3608.120.23.2.7)
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org


> On Mar 21, 2023, at 4:43 PM, Martin KaFai Lau <martin.lau@linux.dev> =
wrote:
>=20
> On 3/21/23 11:45 AM, Aditi Ghag wrote:
>> diff --git a/include/net/udp.h b/include/net/udp.h
>> index de4b528522bb..d2999447d3f2 100644
>> --- a/include/net/udp.h
>> +++ b/include/net/udp.h
>> @@ -437,6 +437,7 @@ struct udp_seq_afinfo {
>>  struct udp_iter_state {
>>  	struct seq_net_private  p;
>>  	int			bucket;
>> +	int			offset;
>=20
> All offset change is easier to review with patch 1 together, so please =
move them to patch 1.

Thanks for the quick review!=20

Oh boy... Absolutely! Looks like I misplaced the changes during =
interactive rebase. Can I fix this up in this patch itself instead of =
creating a new patch series? That way, I can batch things up in the next =
revision.=20

>=20
>>  	struct udp_seq_afinfo	*bpf_seq_afinfo;
>>  };
>>  diff --git a/net/core/filter.c b/net/core/filter.c
>> index 1d6f165923bf..ba3e0dac119c 100644
>> --- a/net/core/filter.c
>> +++ b/net/core/filter.c
>> @@ -11621,3 +11621,57 @@ bpf_sk_base_func_proto(enum bpf_func_id =
func_id)
>>    	return func;
>>  }
>> +
>> +/* Disables missing prototype warnings */
>> +__diag_push();
>> +__diag_ignore_all("-Wmissing-prototypes",
>> +		  "Global functions as their definitions will be in =
vmlinux BTF");
>> +
>> +/* bpf_sock_destroy: Destroy the given socket with ECONNABORTED =
error code.
>> + *
>> + * The helper expects a non-NULL pointer to a socket. It invokes the
>> + * protocol specific socket destroy handlers.
>> + *
>> + * The helper can only be called from BPF contexts that have =
acquired the socket
>> + * locks.
>> + *
>> + * Parameters:
>> + * @sock: Pointer to socket to be destroyed
>> + *
>> + * Return:
>> + * On error, may return EPROTONOSUPPORT, EINVAL.
>> + * EPROTONOSUPPORT if protocol specific destroy handler is not =
implemented.
>> + * 0 otherwise
>> + */
>> +__bpf_kfunc int bpf_sock_destroy(struct sock_common *sock)
>> +{
>> +	struct sock *sk =3D (struct sock *)sock;
>> +
>> +	if (!sk)
>> +		return -EINVAL;
>> +
>> +	/* The locking semantics that allow for synchronous execution of =
the
>> +	 * destroy handlers are only supported for TCP and UDP.
>> +	 */
>> +	if (!sk->sk_prot->diag_destroy || sk->sk_protocol =3D=3D =
IPPROTO_RAW)
>> +		return -EOPNOTSUPP;
>> +
>> +	return sk->sk_prot->diag_destroy(sk, ECONNABORTED);
>> +}
>> +
>> +__diag_pop()
>> +
>> +BTF_SET8_START(sock_destroy_kfunc_set)
>> +BTF_ID_FLAGS(func, bpf_sock_destroy)
>> +BTF_SET8_END(sock_destroy_kfunc_set)
>> +
>> +static const struct btf_kfunc_id_set bpf_sock_destroy_kfunc_set =3D =
{
>> +	.owner =3D THIS_MODULE,
>> +	.set   =3D &sock_destroy_kfunc_set,
>> +};
>> +
>> +static int init_subsystem(void)
>> +{
>> +	return register_btf_kfunc_id_set(BPF_PROG_TYPE_TRACING, =
&bpf_sock_destroy_kfunc_set);
>=20
> It still needs a way to guarantee the running context is safe to use =
this kfunc.  BPF_PROG_TYPE_TRACING is too broad. Trying to brainstorm =
ways here instead of needing to filter by expected_attach_type. I wonder =
using KF_TRUSTED_ARGS like this:
>=20
> BTF_ID_FLAGS(func, bpf_sock_destroy, KF_TRUSTED_ARGS)
>=20
> is enough or it needs some care to filter out BPF_TRACE_RAW_TP after =
looking at prog_args_trusted().
> or it needs another tag to specify this kfunc requires the arg to be =
locked also.
>=20


Agreed. We had some open ended discussion in the earlier patch.=20


>> +}
>> +late_initcall(init_subsystem);
>> diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
>> index 33f559f491c8..59a833c0c872 100644
>> --- a/net/ipv4/tcp.c
>> +++ b/net/ipv4/tcp.c
>> @@ -4678,8 +4678,10 @@ int tcp_abort(struct sock *sk, int err)
>>  		return 0;
>>  	}
>>  -	/* Don't race with userspace socket closes such as tcp_close. */
>> -	lock_sock(sk);
>> +	/* BPF context ensures sock locking. */
>> +	if (!has_current_bpf_ctx())
>> +		/* Don't race with userspace socket closes such as =
tcp_close. */
>> +		lock_sock(sk);
>=20
> This is ok.
>=20
>>    	if (sk->sk_state =3D=3D TCP_LISTEN) {
>>  		tcp_set_state(sk, TCP_CLOSE);
>> @@ -4688,7 +4690,8 @@ int tcp_abort(struct sock *sk, int err)
>>    	/* Don't race with BH socket closes such as =
inet_csk_listen_stop. */
>>  	local_bh_disable();
>> -	bh_lock_sock(sk);
>> +	if (!has_current_bpf_ctx())
>> +		bh_lock_sock(sk);
>=20
> This may or may not work, depending on the earlier lock_sock_fast() =
done in bpf_iter_tcp_seq_show() returned true or false. It is probably a =
good reason to replace the lock_sock_fast() with lock_sock() in =
bpf_iter_tcp_seq_show().


:) We would have to replace lock_sock_fast with lock_sock anyway, else =
this causes problems in inet_unhash while destroying TCP listening =
socket, see - =
https://lore.kernel.org/bpf/20230321184541.1857363-1-aditi.ghag@isovalent.=
com/T/#m0bb85df6482e7eae296b00394c482254db544748.=20


>=20
>>    	if (!sock_flag(sk, SOCK_DEAD)) {
>>  		sk->sk_err =3D err;
>> @@ -4700,10 +4703,13 @@ int tcp_abort(struct sock *sk, int err)
>>  		tcp_done(sk);
>>  	}
>>  -	bh_unlock_sock(sk);
>> +	if (!has_current_bpf_ctx())
>> +		bh_unlock_sock(sk);
>> +
>>  	local_bh_enable();
>>  	tcp_write_queue_purge(sk);
>> -	release_sock(sk);
>> +	if (!has_current_bpf_ctx())
>> +		release_sock(sk);
>>  	return 0;
>>  }
>>  EXPORT_SYMBOL_GPL(tcp_abort);
>=20

