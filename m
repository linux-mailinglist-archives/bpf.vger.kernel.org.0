Return-Path: <bpf+bounces-6000-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E53A76411B
	for <lists+bpf@lfdr.de>; Wed, 26 Jul 2023 23:25:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4084D1C213F5
	for <lists+bpf@lfdr.de>; Wed, 26 Jul 2023 21:25:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B6C7C141;
	Wed, 26 Jul 2023 21:25:10 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 272011BF07
	for <bpf@vger.kernel.org>; Wed, 26 Jul 2023 21:25:09 +0000 (UTC)
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 848A52685
	for <bpf@vger.kernel.org>; Wed, 26 Jul 2023 14:25:06 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-cf4cb742715so178487276.2
        for <bpf@vger.kernel.org>; Wed, 26 Jul 2023 14:25:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1690406705; x=1691011505;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=rbtSLXIaLXKU8eMZQBoadYtmpsOOtw3wsvRHUNbqarA=;
        b=LJV44t3YVmUdRuDbRPxzfNIK3DWldNkFIYED4fnVpl4qCgeMiTHHWXYZLtfaPCkDQG
         lDk2glCtn3TAN0isoeQw61heBVs4xHCu7VU0lFBokwSc2L8s8SNBjXkvFFGm6XDa56dM
         bCmvBVK1HG4nFSHwdz1kcC+AG1Pn1ivWZPN1A1X0ICDDjpJsmFmfluvjsMjuB10/hwmV
         B7FQdihDwlxrImf38Ap9LL1//KOS0rBQZ8Y43V3R0adGpMQqaElfebntMuaJ+OXUrNV1
         1NsiRRVs9fHSiE8Xo6STaddKzA5BgQpZ56DVyhsMiq0pWxYtiP6OLcw17R0rHN7+Gwkt
         8jMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690406706; x=1691011506;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rbtSLXIaLXKU8eMZQBoadYtmpsOOtw3wsvRHUNbqarA=;
        b=BNPVPETx/rN6oHu/RjdgQXSOBejbsk4dVOI/1u+4HyG8Hpn6LCLo4oKXf/XzVpe3ty
         IBfGaU3ujTXkmAL3jjiVqwm2Kz5NJja+1CpeBN4U4gUgfw126KJeiX5XlLK2VOS1jZh7
         7Qizb7pdCFQTcvXeneNRmAfZA72InOjzTu5lQNwkzM8tUb1upK1vYQu4eCP9WIdhXMfm
         r+oBRXOnEWT18m6EexWPGPASws29cMphysxpfqpa9j+nPMzxuTufRQgDX0JQl2qH8wP0
         c6IPpqi/Bckfj08VFEtHd0KiccoIxtWlCPrvCpbo6NUXJRNPPxMUdalCMQGFAk0nqAvf
         kvrg==
X-Gm-Message-State: ABy/qLbJgjz+vJ/IuEukFL3s4Sc5j2/DFdcg1swlpB4T5gLPLdAgOg3H
	48lli1S1T2LgULVcXQXZ5KJhAm0=
X-Google-Smtp-Source: APBJJlHOTZvfYCfN22sZ1V4eMrTkJT8xjSnaZjuMj+ZaavFFza+m5eyazkCam4Uovgf5RTEflXBIYbI=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a05:6902:28d:b0:cb6:6c22:d0f8 with SMTP id
 v13-20020a056902028d00b00cb66c22d0f8mr18847ybh.4.1690406705775; Wed, 26 Jul
 2023 14:25:05 -0700 (PDT)
Date: Wed, 26 Jul 2023 14:25:04 -0700
In-Reply-To: <383cc1ce-3c87-4b80-9e70-e0c10a7c1dcc@redhat.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20230724235957.1953861-1-sdf@google.com> <20230724235957.1953861-3-sdf@google.com>
 <383cc1ce-3c87-4b80-9e70-e0c10a7c1dcc@redhat.com>
Message-ID: <ZMGPMIpeBsfs4/8L@google.com>
Subject: Re: [xdp-hints] [RFC net-next v4 2/8] xsk: add TX timestamp and TX
 checksum offload support
From: Stanislav Fomichev <sdf@google.com>
To: Jesper Dangaard Brouer <jbrouer@redhat.com>
Cc: bpf@vger.kernel.org, brouer@redhat.com, ast@kernel.org, 
	daniel@iogearbox.net, andrii@kernel.org, martin.lau@linux.dev, 
	song@kernel.org, yhs@fb.com, john.fastabend@gmail.com, kpsingh@kernel.org, 
	haoluo@google.com, jolsa@kernel.org, kuba@kernel.org, toke@kernel.org, 
	willemb@google.com, dsahern@kernel.org, magnus.karlsson@intel.com, 
	bjorn@kernel.org, maciej.fijalkowski@intel.com, hawk@kernel.org, 
	netdev@vger.kernel.org, xdp-hints@xdp-project.net
Content-Type: text/plain; charset="utf-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 07/26, Jesper Dangaard Brouer wrote:
> 
> 
> On 25/07/2023 01.59, Stanislav Fomichev wrote:
> > diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
> > index 11652e464f5d..8b40c80557aa 100644
> > --- a/include/linux/netdevice.h
> > +++ b/include/linux/netdevice.h
> > @@ -1660,6 +1660,31 @@ struct xdp_metadata_ops {
> >   			       enum xdp_rss_hash_type *rss_type);
> >   };
> > +/*
> > + * This structure defines the AF_XDP TX metadata hooks for network devices.
> > + * The following hooks can be defined; unless noted otherwise, they are
> > + * optional and can be filled with a null pointer.
> > + *
> > + * int (*tmo_request_timestamp)(void *priv)
> > + *     This function is called when AF_XDP frame requested egress timestamp.
> > + *
> > + * int (*tmo_fill_timestamp)(void *priv)
> > + *     This function is called when AF_XDP frame, that had requested
> > + *     egress timestamp, received a completion. The hook needs to return
> > + *     the actual HW timestamp.
> > + *
> > + * int (*tmo_request_timestamp)(u16 csum_start, u16 csum_offset, void *priv)
> > + *     This function is called when AF_XDP frame requested HW checksum
> > + *     offload. csum_start indicates position where checksumming should start.
> > + *     csum_offset indicates position where checksum should be stored.
> > + *
> > + */
> > +struct xsk_tx_metadata_ops {
> > +	void	(*tmo_request_timestamp)(void *priv);
> > +	u64	(*tmo_fill_timestamp)(void *priv);
> > +	void	(*tmo_request_checksum)(u16 csum_start, u16 csum_offset, void *priv);
> > +};
> > +
> >   /**
> >    * enum netdev_priv_flags - &struct net_device priv_flags
> >    *
> > @@ -1844,6 +1869,7 @@ enum netdev_ml_priv_type {
> >    *	@netdev_ops:	Includes several pointers to callbacks,
> >    *			if one wants to override the ndo_*() functions
> >    *	@xdp_metadata_ops:	Includes pointers to XDP metadata callbacks.
> > + *	@xsk_tx_metadata_ops:	Includes pointers to AF_XDP TX metadata callbacks.
> >    *	@ethtool_ops:	Management operations
> >    *	@l3mdev_ops:	Layer 3 master device operations
> >    *	@ndisc_ops:	Includes callbacks for different IPv6 neighbour
> > @@ -2100,6 +2126,7 @@ struct net_device {
> >   	unsigned long long	priv_flags;
> >   	const struct net_device_ops *netdev_ops;
> >   	const struct xdp_metadata_ops *xdp_metadata_ops;
> > +	const struct xsk_tx_metadata_ops *xsk_tx_metadata_ops;
> >   	int			ifindex;
> >   	unsigned short		gflags;
> >   	unsigned short		hard_header_len;
> > diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
> > index faaba050f843..5febc1a5131e 100644
> > --- a/include/linux/skbuff.h
> > +++ b/include/linux/skbuff.h
> > @@ -581,7 +581,10 @@ struct skb_shared_info {
> >   	/* Warning: this field is not always filled in (UFO)! */
> >   	unsigned short	gso_segs;
> >   	struct sk_buff	*frag_list;
> > -	struct skb_shared_hwtstamps hwtstamps;
> > +	union {
> > +		struct skb_shared_hwtstamps hwtstamps;
> > +		struct xsk_tx_metadata *xsk_meta;
> > +	};
> >   	unsigned int	gso_type;
> >   	u32		tskey;
> > diff --git a/include/net/xdp_sock.h b/include/net/xdp_sock.h
> > index 467b9fb56827..288fa58c4665 100644
> > --- a/include/net/xdp_sock.h
> > +++ b/include/net/xdp_sock.h
> > @@ -90,6 +90,54 @@ int xsk_generic_rcv(struct xdp_sock *xs, struct xdp_buff *xdp);
> >   int __xsk_map_redirect(struct xdp_sock *xs, struct xdp_buff *xdp);
> >   void __xsk_map_flush(void);
> > +/**
> > + *  xsk_tx_metadata_request - Evaluate AF_XDP TX metadata at submission
> > + *  and call appropriate xsk_tx_metadata_ops operation.
> > + *  @meta: pointer to AF_XDP metadata area
> > + *  @ops: pointer to struct xsk_tx_metadata_ops
> > + *  @priv: pointer to driver-private aread
> > + *
> > + *  This function should be called by the networking device when
> > + *  it prepares AF_XDP egress packet.
> > + */
> > +static inline void xsk_tx_metadata_request(const struct xsk_tx_metadata *meta,
> > +					   const struct xsk_tx_metadata_ops *ops,
> > +					   void *priv)
> 
> (As you mentioned) this gets inlined in drivers for performance.
> 
> > +{
> > +	if (!meta)
> > +		return;
> > +
> > +	if (ops->tmo_request_timestamp)
> > +		if (meta->flags & XDP_TX_METADATA_TIMESTAMP)
> > +			ops->tmo_request_timestamp(priv);
> 
> We still have the overhead of function pointer call.
> With RETPOLINE this is costly.
> 
> Measured on my testlab CPU E5-1650 v4 @ 3.60GHz
>  Type:function_call_cost:  3 cycles(tsc) 1.010 ns
>  Type:func_ptr_call_cost: 30 cycles(tsc) 8.341 ns
> 
> Given this get inlined in drivers, perhaps we can add some
> INDIRECT_CALL_1 macros to avoid these indirect calls?

I'm assuming that the compiler is smart enough to resolve these const
struct ops definitions as long as they are in the same file.

At least here is what I see for mlx5e_xmit_xdp_frame_mpwqe: those
indirect jumps are resolved and the calls themselves are unrolled.
TBF, I don't have retpolines enabled in the config, but I don't think
it will bring indirect jumps back? Am I missing anything?


0000000000001930 <mlx5e_xmit_xdp_frame_mpwqe>:
; mlx5e_xmit_xdp_frame_mpwqe():
; ./drivers/net/ethernet/mellanox/mlx5/core/en/xdp.c:436
; {
    1930: f3 0f 1e fa                  	endbr64
    1934: e8 00 00 00 00               	callq	0x1939 <mlx5e_xmit_xdp_frame_mpwqe+0x9>
		0000000000001935:  R_X86_64_PLT32	__fentry__-0x4
    1939: 55                           	pushq	%rbp
    193a: 48 89 e5                     	movq	%rsp, %rbp
    193d: 41 57                        	pushq	%r15
    193f: 41 56                        	pushq	%r14
    1941: 41 54                        	pushq	%r12
    1943: 53                           	pushq	%rbx
    1944: 48 83 ec 18                  	subq	$0x18, %rsp
    1948: 49 89 cf                     	movq	%rcx, %r15
    194b: 49 89 f6                     	movq	%rsi, %r14
    194e: 48 89 fb                     	movq	%rdi, %rbx
; ./drivers/net/ethernet/mellanox/mlx5/core/en/xdp.c:438
; 	struct mlx5e_xdpsq_stats *stats = sq->stats;
    1951: 4c 8b a7 30 02 00 00         	movq	0x230(%rdi), %r12
; ./drivers/net/ethernet/mellanox/mlx5/core/en/xdp.c:442
; 	if (xdptxd->has_frags) {
    1958: 8b 46 10                     	movl	0x10(%rsi), %eax
    195b: 85 c0                        	testl	%eax, %eax
    195d: 0f 88 ec 00 00 00            	js	0x1a4f <mlx5e_xmit_xdp_frame_mpwqe+0x11f>
; ./drivers/net/ethernet/mellanox/mlx5/core/en/xdp.c:467
; 	if (unlikely(p->len > sq->hw_mtu)) {
    1963: 25 ff ff ff 7f               	andl	$0x7fffffff, %eax       # imm = 0x7FFFFFFF
    1968: 3b 83 98 02 00 00            	cmpl	0x298(%rbx), %eax
    196e: 0f 87 b5 02 00 00            	ja	0x1c29 <mlx5e_xmit_xdp_frame_mpwqe+0x2f9>
; ./drivers/net/ethernet/mellanox/mlx5/core/en/xdp.c:472
; 	if (!check_result)
    1974: 85 d2                        	testl	%edx, %edx
    1976: 0f 84 40 01 00 00            	je	0x1abc <mlx5e_xmit_xdp_frame_mpwqe+0x18c>
; ./drivers/net/ethernet/mellanox/mlx5/core/en/xdp.c:474
; 	if (unlikely(check_result < 0))
    197c: 0f 88 ac 02 00 00            	js	0x1c2e <mlx5e_xmit_xdp_frame_mpwqe+0x2fe>
; ./drivers/net/ethernet/mellanox/mlx5/core/en/xdp.c:477
; 	if (check_result == MLX5E_XDP_CHECK_START_MPWQE) {
    1982: 83 fa 02                     	cmpl	$0x2, %edx
    1985: 0f 85 d7 01 00 00            	jne	0x1b62 <mlx5e_xmit_xdp_frame_mpwqe+0x232>
; ./drivers/net/ethernet/mellanox/mlx5/core/en/xdp.c:338
; 	pi = mlx5_wq_cyc_ctr2ix(wq, sq->pc);
    198b: 0f b7 4b 44                  	movzwl	0x44(%rbx), %ecx
    198f: 8b 93 10 02 00 00            	movl	0x210(%rbx), %edx
; ./drivers/net/ethernet/mellanox/mlx5/core/wq.h:144
; 	return ctr & wq->fbc.sz_m1;
    1995: 21 d1                        	andl	%edx, %ecx
; ./drivers/net/ethernet/mellanox/mlx5/core/wq.h:164
; 	return mlx5_frag_buf_get_idx_last_contig_stride(&wq->fbc, ix) - ix + 1;
    1997: 0f b7 c1                     	movzwl	%cx, %eax
; ././include/linux/mlx5/driver.h:959
; 	u32 last_frag_stride_idx = (ix + fbc->strides_offset) | fbc->frag_sz_m1;
    199a: 44 0f b7 8b 16 02 00 00      	movzwl	0x216(%rbx), %r9d
    19a2: 42 8d 3c 08                  	leal	(%rax,%r9), %edi
    19a6: 0f b7 b3 14 02 00 00         	movzwl	0x214(%rbx), %esi
    19ad: 41 89 f8                     	movl	%edi, %r8d
    19b0: 41 09 f0                     	orl	%esi, %r8d
; ././include/linux/mlx5/driver.h:961
; 	return min_t(u32, last_frag_stride_idx - fbc->strides_offset, fbc->sz_m1);
    19b3: 45 29 c8                     	subl	%r9d, %r8d
    19b6: 41 39 d0                     	cmpl	%edx, %r8d
    19b9: 44 0f 43 c2                  	cmovael	%edx, %r8d
; ./drivers/net/ethernet/mellanox/mlx5/core/en/xdp.c:369
; 	pi = mlx5e_xdpsq_get_next_pi(sq, sq->max_sq_mpw_wqebbs);
    19bd: 0f b6 93 8e 02 00 00         	movzbl	0x28e(%rbx), %edx
; ./drivers/net/ethernet/mellanox/mlx5/core/wq.h:164
; 	return mlx5_frag_buf_get_idx_last_contig_stride(&wq->fbc, ix) - ix + 1;
    19c4: 41 29 c8                     	subl	%ecx, %r8d
    19c7: 41 ff c0                     	incl	%r8d
; ./drivers/net/ethernet/mellanox/mlx5/core/en/xdp.c:340
; 	if (unlikely(contig_wqebbs < size)) {
    19ca: 66 41 39 d0                  	cmpw	%dx, %r8w
    19ce: 0f 82 5e 02 00 00            	jb	0x1c32 <mlx5e_xmit_xdp_frame_mpwqe+0x302>
; ././include/linux/mlx5/driver.h:951
; 	frag = ix >> fbc->log_frag_strides;
    19d4: 0f b6 8b 1a 02 00 00         	movzbl	0x21a(%rbx), %ecx
; ././include/linux/mlx5/driver.h:953
; 	return fbc->frags[frag].buf + ((fbc->frag_sz_m1 & ix) << fbc->log_stride);
    19db: 89 f8                        	movl	%edi, %eax
; ././include/linux/mlx5/driver.h:951
; 	frag = ix >> fbc->log_frag_strides;
    19dd: 48 d3 e8                     	shrq	%cl, %rax
; ././include/linux/mlx5/driver.h:953
; 	return fbc->frags[frag].buf + ((fbc->frag_sz_m1 & ix) << fbc->log_stride);
    19e0: 48 8b 8b 08 02 00 00         	movq	0x208(%rbx), %rcx
    19e7: 48 c1 e0 04                  	shlq	$0x4, %rax
    19eb: 48 8b 14 01                  	movq	(%rcx,%rax), %rdx
    19ef: 21 fe                        	andl	%edi, %esi
    19f1: 0f b6 8b 19 02 00 00         	movzbl	0x219(%rbx), %ecx
    19f8: d3 e6                        	shll	%cl, %esi
    19fa: 48 8d 04 32                  	leaq	(%rdx,%rsi), %rax
; ./drivers/net/ethernet/mellanox/mlx5/core/en/txrx.h:114
; 	memset(wqe, 0, wqe_size);
    19fe: 48 c7 44 32 18 00 00 00 00   	movq	$0x0, 0x18(%rdx,%rsi)
    1a07: 48 c7 44 32 10 00 00 00 00   	movq	$0x0, 0x10(%rdx,%rsi)
    1a10: 48 c7 44 32 08 00 00 00 00   	movq	$0x0, 0x8(%rdx,%rsi)
    1a19: 48 c7 04 32 00 00 00 00      	movq	$0x0, (%rdx,%rsi)
; ././arch/x86/include/asm/processor.h:618
; 	alternative_input(BASE_PREFETCH, "prefetchw %P1",
    1a21: 0f 18 4c 32 20               	prefetcht0	0x20(%rdx,%rsi)
    1a26: 0f 18 4c 32 60               	prefetcht0	0x60(%rdx,%rsi)
; ./drivers/net/ethernet/mellanox/mlx5/core/en/xdp.c:378
; 		.inline_on = mlx5e_xdp_get_inline_state(sq, session->inline_on),
    1a2b: 0f b6 4b 5e                  	movzbl	0x5e(%rbx), %ecx
    1a2f: 8b 53 40                     	movl	0x40(%rbx), %edx
; ./drivers/net/ethernet/mellanox/mlx5/core/en/xdp.h:168
; 	u16 outstanding = sq->xdpi_fifo_pc - sq->xdpi_fifo_cc;
    1a32: 2b 13                        	subl	(%rbx), %edx
    1a34: 0f b7 d2                     	movzwl	%dx, %edx
; ./drivers/net/ethernet/mellanox/mlx5/core/en/xdp.c:378
; 		.inline_on = mlx5e_xdp_get_inline_state(sq, session->inline_on),
    1a37: 84 c9                        	testb	%cl, %cl
; ./drivers/net/ethernet/mellanox/mlx5/core/en/xdp.h:173
; 	if (cur && outstanding <= MLX5E_XDP_INLINE_WATERMARK_LOW)
    1a39: 0f 84 e8 00 00 00            	je	0x1b27 <mlx5e_xmit_xdp_frame_mpwqe+0x1f7>
    1a3f: 83 fa 0b                     	cmpl	$0xb, %edx
    1a42: 0f 83 df 00 00 00            	jae	0x1b27 <mlx5e_xmit_xdp_frame_mpwqe+0x1f7>
    1a48: 31 c9                        	xorl	%ecx, %ecx
    1a4a: e9 e7 00 00 00               	jmp	0x1b36 <mlx5e_xmit_xdp_frame_mpwqe+0x206>
; ./drivers/net/ethernet/mellanox/mlx5/core/en/xdp.c:446
; 		if (!!xdptxd->len + xdptxdf->sinfo->nr_frags > 1) {
    1a4f: 89 c1                        	movl	%eax, %ecx
    1a51: 81 e1 ff ff ff 7f            	andl	$0x7fffffff, %ecx       # imm = 0x7FFFFFFF
    1a57: 49 8b 76 18                  	movq	0x18(%r14), %rsi
    1a5b: 0f b6 7e 02                  	movzbl	0x2(%rsi), %edi
    1a5f: 83 f9 01                     	cmpl	$0x1, %ecx
    1a62: 83 df ff                     	sbbl	$-0x1, %edi
    1a65: 83 ff 02                     	cmpl	$0x2, %edi
    1a68: 0f 83 99 00 00 00            	jae	0x1b07 <mlx5e_xmit_xdp_frame_mpwqe+0x1d7>
    1a6e: a9 ff ff ff 7f               	testl	$0x7fffffff, %eax       # imm = 0x7FFFFFFF
; ./drivers/net/ethernet/mellanox/mlx5/core/en/xdp.c:455
; 		if (!xdptxd->len) {
    1a73: 0f 85 ea fe ff ff            	jne	0x1963 <mlx5e_xmit_xdp_frame_mpwqe+0x33>
; ./drivers/net/ethernet/mellanox/mlx5/core/en/xdp.c:458
; 			tmp.data = skb_frag_address(frag);
    1a79: 48 8b 7e 30                  	movq	0x30(%rsi), %rdi
    1a7d: 8b 4e 3c                     	movl	0x3c(%rsi), %ecx
; ././include/linux/mm.h:2120
; 	return page_to_virt(page);
    1a80: 48 89 f8                     	movq	%rdi, %rax
    1a83: 48 2b 05 00 00 00 00         	subq	(%rip), %rax            # 0x1a8a <mlx5e_xmit_xdp_frame_mpwqe+0x15a>
		0000000000001a86:  R_X86_64_PC32	vmemmap_base-0x4
    1a8a: 48 c1 e0 06                  	shlq	$0x6, %rax
    1a8e: 48 03 05 00 00 00 00         	addq	(%rip), %rax            # 0x1a95 <mlx5e_xmit_xdp_frame_mpwqe+0x165>
		0000000000001a91:  R_X86_64_PC32	page_offset_base-0x4
; ././include/linux/skbuff.h:3478
; 	return page_address(skb_frag_page(frag)) + skb_frag_off(frag);
    1a95: 48 01 c8                     	addq	%rcx, %rax
; ./drivers/net/ethernet/mellanox/mlx5/core/en/xdp.c:458
; 			tmp.data = skb_frag_address(frag);
    1a98: 48 89 45 d0                  	movq	%rax, -0x30(%rbp)
    1a9c: b8 ff ff ff 7f               	movl	$0x7fffffff, %eax       # imm = 0x7FFFFFFF
; ./drivers/net/ethernet/mellanox/mlx5/core/en/xdp.c:459
; 			tmp.len = skb_frag_size(frag);
    1aa1: 23 46 38                     	andl	0x38(%rsi), %eax
    1aa4: 89 45 d8                     	movl	%eax, -0x28(%rbp)
; ./drivers/net/ethernet/mellanox/mlx5/core/en/xdp.c:460
; 			tmp.dma_addr = xdptxdf->dma_arr ? xdptxdf->dma_arr[0] :
    1aa7: 49 8b 76 20                  	movq	0x20(%r14), %rsi
    1aab: 48 85 f6                     	testq	%rsi, %rsi
    1aae: 0f 84 64 01 00 00            	je	0x1c18 <mlx5e_xmit_xdp_frame_mpwqe+0x2e8>
    1ab4: 48 8b 0e                     	movq	(%rsi), %rcx
    1ab7: e9 60 01 00 00               	jmp	0x1c1c <mlx5e_xmit_xdp_frame_mpwqe+0x2ec>
; ./drivers/net/ethernet/mellanox/mlx5/core/en/xdp.c:414
; 	if (unlikely(!sq->mpwqe.wqe)) {
    1abc: 48 83 7b 50 00               	cmpq	$0x0, 0x50(%rbx)
    1ac1: 0f 85 9b 00 00 00            	jne	0x1b62 <mlx5e_xmit_xdp_frame_mpwqe+0x232>
; ./drivers/net/ethernet/mellanox/mlx5/core/en/xdp.c:415
; 		if (unlikely(!mlx5e_wqc_has_room_for(&sq->wq, sq->cc, sq->pc,
    1ac7: 0f b7 43 04                  	movzwl	0x4(%rbx), %eax
    1acb: 0f b7 4b 44                  	movzwl	0x44(%rbx), %ecx
    1acf: 8b 93 10 02 00 00            	movl	0x210(%rbx), %edx
; ./drivers/net/ethernet/mellanox/mlx5/core/en/txrx.h:106
; 	return (mlx5_wq_cyc_ctr2ix(wq, cc - pc) >= n) || (cc == pc);
    1ad5: 66 29 c8                     	subw	%cx, %ax
; ./drivers/net/ethernet/mellanox/mlx5/core/en/xdp.c:415
; 		if (unlikely(!mlx5e_wqc_has_room_for(&sq->wq, sq->cc, sq->pc,
    1ad8: 0f 84 b7 fe ff ff            	je	0x1995 <mlx5e_xmit_xdp_frame_mpwqe+0x65>
    1ade: 21 d0                        	andl	%edx, %eax
    1ae0: 66 3b 83 8c 02 00 00         	cmpw	0x28c(%rbx), %ax
    1ae7: 0f 83 a8 fe ff ff            	jae	0x1995 <mlx5e_xmit_xdp_frame_mpwqe+0x65>
; ./drivers/net/ethernet/mellanox/mlx5/core/en/xdp.c:418
; 			mlx5e_xmit_xdp_doorbell(sq);
    1aed: 48 89 df                     	movq	%rbx, %rdi
    1af0: e8 0b fc ff ff               	callq	0x1700 <mlx5e_xmit_xdp_doorbell>
; ./drivers/net/ethernet/mellanox/mlx5/core/en/xdp.c:419
; 			sq->stats->full++;
    1af5: 48 8b 83 30 02 00 00         	movq	0x230(%rbx), %rax
    1afc: 48 ff 40 20                  	incq	0x20(%rax)
    1b00: 31 c0                        	xorl	%eax, %eax
    1b02: e9 f2 00 00 00               	jmp	0x1bf9 <mlx5e_xmit_xdp_frame_mpwqe+0x2c9>
; ./drivers/net/ethernet/mellanox/mlx5/core/en/xdp.c:451
; 			if (unlikely(sq->mpwqe.wqe))
    1b07: 48 83 7b 50 00               	cmpq	$0x0, 0x50(%rbx)
    1b0c: 0f 85 03 02 00 00            	jne	0x1d15 <mlx5e_xmit_xdp_frame_mpwqe+0x3e5>
; ./drivers/net/ethernet/mellanox/mlx5/core/en/xdp.c:453
; 			return mlx5e_xmit_xdp_frame(sq, xdptxd, 0, meta);
    1b12: 48 89 df                     	movq	%rbx, %rdi
    1b15: 4c 89 f6                     	movq	%r14, %rsi
    1b18: 31 d2                        	xorl	%edx, %edx
    1b1a: 4c 89 f9                     	movq	%r15, %rcx
    1b1d: e8 0e 02 00 00               	callq	0x1d30 <mlx5e_xmit_xdp_frame>
    1b22: e9 d2 00 00 00               	jmp	0x1bf9 <mlx5e_xmit_xdp_frame_mpwqe+0x2c9>
; ./drivers/net/ethernet/mellanox/mlx5/core/en/xdp.c:378
; 		.inline_on = mlx5e_xdp_get_inline_state(sq, session->inline_on),
    1b27: 84 c9                        	testb	%cl, %cl
    1b29: 40 0f 95 c6                  	setne	%sil
    1b2d: 83 fa 7f                     	cmpl	$0x7f, %edx
    1b30: 0f 97 c1                     	seta	%cl
    1b33: 40 08 f1                     	orb	%sil, %cl
; ./drivers/net/ethernet/mellanox/mlx5/core/en/xdp.c:373
; 	*session = (struct mlx5e_tx_mpwqe) {
    1b36: 48 89 43 50                  	movq	%rax, 0x50(%rbx)
    1b3a: c7 43 58 00 00 00 00         	movl	$0x0, 0x58(%rbx)
    1b41: 66 c7 43 5c 02 00            	movw	$0x2, 0x5c(%rbx)
    1b47: 88 4b 5e                     	movb	%cl, 0x5e(%rbx)
; ./drivers/net/ethernet/mellanox/mlx5/core/en/xdp.c:381
; 	stats->mpwqe++;
    1b4a: 49 ff 44 24 08               	incq	0x8(%r12)
; ././include/net/xdp_sock.h:107
; 	if (!meta)
    1b4f: 4d 85 ff                     	testq	%r15, %r15
    1b52: 74 0e                        	je	0x1b62 <mlx5e_xmit_xdp_frame_mpwqe+0x232>
; ././include/net/xdp_sock.h:115
; 		if (meta->flags & XDP_TX_METADATA_CHECKSUM)
    1b54: 41 f6 07 02                  	testb	$0x2, (%r15)
    1b58: 74 08                        	je	0x1b62 <mlx5e_xmit_xdp_frame_mpwqe+0x232>
; ./drivers/net/ethernet/mellanox/mlx5/core/en/xdp.c:483
; 		xsk_tx_metadata_request(meta, &mlx5e_xsk_tx_metadata_ops, &session->wqe->eth);
    1b5a: 48 8b 43 50                  	movq	0x50(%rbx), %rax
; ./drivers/net/ethernet/mellanox/mlx5/core/en/xdp.c:286
; 	eseg->cs_flags |= MLX5_ETH_WQE_L3_CSUM | MLX5_ETH_WQE_L4_CSUM;
    1b5e: 80 48 14 c0                  	orb	$-0x40, 0x14(%rax)
; ./drivers/net/ethernet/mellanox/mlx5/core/en/xdp.h:203
; 		(struct mlx5_wqe_data_seg *)session->wqe + session->ds_count;
    1b62: 48 8b 43 50                  	movq	0x50(%rbx), %rax
    1b66: 0f b6 4b 5c                  	movzbl	0x5c(%rbx), %ecx
    1b6a: 41 8b 76 10                  	movl	0x10(%r14), %esi
; ./drivers/net/ethernet/mellanox/mlx5/core/en/xdp.h:204
; 	u32 dma_len = xdptxd->len;
    1b6e: 89 f2                        	movl	%esi, %edx
; ./drivers/net/ethernet/mellanox/mlx5/core/en/xdp.h:206
; 	session->pkt_count++;
    1b70: fe 43 5d                     	incb	0x5d(%rbx)
; ./drivers/net/ethernet/mellanox/mlx5/core/en/xdp.h:204
; 	u32 dma_len = xdptxd->len;
    1b73: 81 e2 ff ff ff 7f            	andl	$0x7fffffff, %edx       # imm = 0x7FFFFFFF
; ./drivers/net/ethernet/mellanox/mlx5/core/en/xdp.h:207
; 	session->bytes_count += dma_len;
    1b79: 01 53 58                     	addl	%edx, 0x58(%rbx)
; ./drivers/net/ethernet/mellanox/mlx5/core/en/xdp.h:203
; 		(struct mlx5_wqe_data_seg *)session->wqe + session->ds_count;
    1b7c: 48 c1 e1 04                  	shlq	$0x4, %rcx
    1b80: 48 8d 3c 08                  	leaq	(%rax,%rcx), %rdi
; ./drivers/net/ethernet/mellanox/mlx5/core/en/xdp.h:209
; 	if (session->inline_on && dma_len <= MLX5E_XDP_INLINE_WQE_SZ_THRSD) {
    1b84: 80 7b 5e 00                  	cmpb	$0x0, 0x5e(%rbx)
    1b88: 74 32                        	je	0x1bbc <mlx5e_xmit_xdp_frame_mpwqe+0x28c>
    1b8a: 81 fa fc 00 00 00            	cmpl	$0xfc, %edx
    1b90: 77 2a                        	ja	0x1bbc <mlx5e_xmit_xdp_frame_mpwqe+0x28c>
; ./drivers/net/ethernet/mellanox/mlx5/core/en/xdp.h:213
; 		u16 ds_cnt = DIV_ROUND_UP(ds_len, MLX5_SEND_WQE_DS);
    1b92: 44 8d 7e 13                  	leal	0x13(%rsi), %r15d
    1b96: 41 c1 ef 04                  	shrl	$0x4, %r15d
; ./drivers/net/ethernet/mellanox/mlx5/core/en/xdp.h:215
; 		inline_dseg->byte_count = cpu_to_be32(dma_len | MLX5_INLINE_SEG);
    1b9a: 81 ce 00 00 00 80            	orl	$0x80000000, %esi       # imm = 0x80000000
    1ba0: 0f ce                        	bswapl	%esi
    1ba2: 89 37                        	movl	%esi, (%rdi)
; ./drivers/net/ethernet/mellanox/mlx5/core/en/xdp.h:216
; 		memcpy(inline_dseg->data, xdptxd->data, dma_len);
    1ba4: 48 83 c7 04                  	addq	$0x4, %rdi
    1ba8: 49 8b 76 08                  	movq	0x8(%r14), %rsi
    1bac: e8 00 00 00 00               	callq	0x1bb1 <mlx5e_xmit_xdp_frame_mpwqe+0x281>
		0000000000001bad:  R_X86_64_PLT32	memcpy-0x4
; ./drivers/net/ethernet/mellanox/mlx5/core/en/xdp.h:218
; 		session->ds_count += ds_cnt;
    1bb1: 44 00 7b 5c                  	addb	%r15b, 0x5c(%rbx)
; ./drivers/net/ethernet/mellanox/mlx5/core/en/xdp.h:219
; 		stats->inlnw++;
    1bb5: 49 ff 44 24 10               	incq	0x10(%r12)
    1bba: eb 1c                        	jmp	0x1bd8 <mlx5e_xmit_xdp_frame_mpwqe+0x2a8>
; ./drivers/net/ethernet/mellanox/mlx5/core/en/xdp.h:223
; 	dseg->addr       = cpu_to_be64(xdptxd->dma_addr);
    1bbc: 49 8b 36                     	movq	(%r14), %rsi
    1bbf: 48 0f ce                     	bswapq	%rsi
    1bc2: 48 89 74 08 08               	movq	%rsi, 0x8(%rax,%rcx)
; ./drivers/net/ethernet/mellanox/mlx5/core/en/xdp.h:224
; 	dseg->byte_count = cpu_to_be32(dma_len);
    1bc7: 0f ca                        	bswapl	%edx
    1bc9: 89 17                        	movl	%edx, (%rdi)
; ./drivers/net/ethernet/mellanox/mlx5/core/en/xdp.h:225
; 	dseg->lkey       = sq->mkey_be;
    1bcb: 8b 93 88 02 00 00            	movl	0x288(%rbx), %edx
    1bd1: 89 54 08 04                  	movl	%edx, 0x4(%rax,%rcx)
; ./drivers/net/ethernet/mellanox/mlx5/core/en/xdp.h:226
; 	session->ds_count++;
    1bd5: fe 43 5c                     	incb	0x5c(%rbx)
; ./drivers/net/ethernet/mellanox/mlx5/core/en/xdp.c:488
; 	if (unlikely(mlx5e_xdp_mpwqe_is_full(session, sq->max_sq_mpw_wqebbs)))
    1bd8: 0f b6 83 8e 02 00 00         	movzbl	0x28e(%rbx), %eax
; ./drivers/net/ethernet/mellanox/mlx5/core/en/xdp.h:184
; 	if (session->inline_on)
    1bdf: 80 7b 5e 00                  	cmpb	$0x0, 0x5e(%rbx)
    1be3: 0f b6 4b 5c                  	movzbl	0x5c(%rbx), %ecx
; ./drivers/net/ethernet/mellanox/mlx5/core/en/xdp.h:184
; 	if (session->inline_on)
    1be7: 74 1e                        	je	0x1c07 <mlx5e_xmit_xdp_frame_mpwqe+0x2d7>
; ./drivers/net/ethernet/mellanox/mlx5/core/en/xdp.h:185
; 		return session->ds_count + MLX5E_XDP_INLINE_WQE_MAX_DS_CNT >
    1be9: 83 c1 10                     	addl	$0x10, %ecx
; ./drivers/net/ethernet/mellanox/mlx5/core/en/xdp.h:186
; 		       max_sq_mpw_wqebbs * MLX5_SEND_WQEBB_NUM_DS;
    1bec: c1 e0 02                     	shll	$0x2, %eax
; ./drivers/net/ethernet/mellanox/mlx5/core/en/xdp.h:185
; 		return session->ds_count + MLX5E_XDP_INLINE_WQE_MAX_DS_CNT >
    1bef: 39 c1                        	cmpl	%eax, %ecx
; ./drivers/net/ethernet/mellanox/mlx5/core/en/xdp.c:488
; 	if (unlikely(mlx5e_xdp_mpwqe_is_full(session, sq->max_sq_mpw_wqebbs)))
    1bf1: 77 1b                        	ja	0x1c0e <mlx5e_xmit_xdp_frame_mpwqe+0x2de>
; ./drivers/net/ethernet/mellanox/mlx5/core/en/xdp.c:491
; 	stats->xmit++;
    1bf3: 49 ff 04 24                  	incq	(%r12)
    1bf7: b0 01                        	movb	$0x1, %al
; ./drivers/net/ethernet/mellanox/mlx5/core/en/xdp.c:493
; }
    1bf9: 48 83 c4 18                  	addq	$0x18, %rsp
    1bfd: 5b                           	popq	%rbx
    1bfe: 41 5c                        	popq	%r12
    1c00: 41 5e                        	popq	%r14
    1c02: 41 5f                        	popq	%r15
    1c04: 5d                           	popq	%rbp
    1c05: c3                           	retq
    1c06: cc                           	int3
; ./drivers/net/ethernet/mellanox/mlx5/core/en/txrx.h:342
; 	return session->ds_count == max_sq_mpw_wqebbs * MLX5_SEND_WQEBB_NUM_DS;
    1c07: c1 e0 02                     	shll	$0x2, %eax
    1c0a: 39 c8                        	cmpl	%ecx, %eax
; ./drivers/net/ethernet/mellanox/mlx5/core/en/xdp.c:488
; 	if (unlikely(mlx5e_xdp_mpwqe_is_full(session, sq->max_sq_mpw_wqebbs)))
    1c0c: 75 e5                        	jne	0x1bf3 <mlx5e_xmit_xdp_frame_mpwqe+0x2c3>
; ./drivers/net/ethernet/mellanox/mlx5/core/en/xdp.c:489
; 		mlx5e_xdp_mpwqe_complete(sq);
    1c0e: 48 89 df                     	movq	%rbx, %rdi
    1c11: e8 00 00 00 00               	callq	0x1c16 <mlx5e_xmit_xdp_frame_mpwqe+0x2e6>
		0000000000001c12:  R_X86_64_PLT32	mlx5e_xdp_mpwqe_complete-0x4
    1c16: eb db                        	jmp	0x1bf3 <mlx5e_xmit_xdp_frame_mpwqe+0x2c3>
; ./drivers/net/ethernet/mellanox/mlx5/core/en/xdp.c:461
; 				page_pool_get_dma_addr(skb_frag_page(frag)) +
    1c18: 48 03 4f 20                  	addq	0x20(%rdi), %rcx
; ./drivers/net/ethernet/mellanox/mlx5/core/en/xdp.c:460
; 			tmp.dma_addr = xdptxdf->dma_arr ? xdptxdf->dma_arr[0] :
    1c1c: 48 89 4d c8                  	movq	%rcx, -0x38(%rbp)
    1c20: 4c 8d 75 c8                  	leaq	-0x38(%rbp), %r14
    1c24: e9 3a fd ff ff               	jmp	0x1963 <mlx5e_xmit_xdp_frame_mpwqe+0x33>
; ./drivers/net/ethernet/mellanox/mlx5/core/en/xdp.c:468
; 		stats->err++;
    1c29: 49 ff 44 24 28               	incq	0x28(%r12)
    1c2e: 31 c0                        	xorl	%eax, %eax
    1c30: eb c7                        	jmp	0x1bf9 <mlx5e_xmit_xdp_frame_mpwqe+0x2c9>
; ./drivers/net/ethernet/mellanox/mlx5/core/en/xdp.c:343
; 		wi = &sq->db.wqe_info[pi];
    1c32: 48 01 c0                     	addq	%rax, %rax
    1c35: 48 03 83 48 02 00 00         	addq	0x248(%rbx), %rax
; ./drivers/net/ethernet/mellanox/mlx5/core/en/xdp.c:344
; 		edge_wi = wi + contig_wqebbs;
    1c3c: 41 0f b7 d0                  	movzwl	%r8w, %edx
    1c40: 48 8d 34 50                  	leaq	(%rax,%rdx,2), %rsi
    1c44: 4c 89 e1                     	movq	%r12, %rcx
; ./drivers/net/ethernet/mellanox/mlx5/core/en/xdp.c:347
; 		for (; wi < edge_wi; wi++) {
    1c47: 48 39 f0                     	cmpq	%rsi, %rax
    1c4a: 0f 83 9f 00 00 00            	jae	0x1cef <mlx5e_xmit_xdp_frame_mpwqe+0x3bf>
; ./drivers/net/ethernet/mellanox/mlx5/core/en/xdp.c:348
; 			*wi = (struct mlx5e_xdp_wqe_info) {
    1c50: 66 c7 00 01 00               	movw	$0x1, (%rax)
    1c55: 0f b7 4b 44                  	movzwl	0x44(%rbx), %ecx
; ./drivers/net/ethernet/mellanox/mlx5/core/en/txrx.h:125
; 	u16                         pi   = mlx5_wq_cyc_ctr2ix(wq, *pc);
    1c59: 0f b7 bb 10 02 00 00         	movzwl	0x210(%rbx), %edi
; ./drivers/net/ethernet/mellanox/mlx5/core/wq.h:144
; 	return ctr & wq->fbc.sz_m1;
    1c60: 21 cf                        	andl	%ecx, %edi
; ././include/linux/mlx5/driver.h:950
; 	ix  += fbc->strides_offset;
    1c62: 44 0f b7 83 16 02 00 00      	movzwl	0x216(%rbx), %r8d
    1c6a: 49 01 f8                     	addq	%rdi, %r8
; ././include/linux/mlx5/driver.h:951
; 	frag = ix >> fbc->log_frag_strides;
    1c6d: 0f b6 8b 1a 02 00 00         	movzbl	0x21a(%rbx), %ecx
; ././include/linux/mlx5/driver.h:953
; 	return fbc->frags[frag].buf + ((fbc->frag_sz_m1 & ix) << fbc->log_stride);
    1c74: 0f b7 bb 14 02 00 00         	movzwl	0x214(%rbx), %edi
    1c7b: 44 21 c7                     	andl	%r8d, %edi
; ././include/linux/mlx5/driver.h:951
; 	frag = ix >> fbc->log_frag_strides;
    1c7e: 49 d3 e8                     	shrq	%cl, %r8
; ./drivers/net/ethernet/mellanox/mlx5/core/en/xdp.c:352
; 			mlx5e_post_nop(wq, sq->sqn, &sq->pc);
    1c81: 44 8b 8b 78 02 00 00         	movl	0x278(%rbx), %r9d
; ././include/linux/mlx5/driver.h:953
; 	return fbc->frags[frag].buf + ((fbc->frag_sz_m1 & ix) << fbc->log_stride);
    1c88: 4c 8b 93 08 02 00 00         	movq	0x208(%rbx), %r10
    1c8f: 49 c1 e0 04                  	shlq	$0x4, %r8
    1c93: 0f b6 8b 19 02 00 00         	movzbl	0x219(%rbx), %ecx
    1c9a: d3 e7                        	shll	%cl, %edi
    1c9c: 4b 8b 0c 02                  	movq	(%r10,%r8), %rcx
; ./drivers/net/ethernet/mellanox/mlx5/core/en/txrx.h:129
; 	memset(cseg, 0, sizeof(*cseg));
    1ca0: 48 c7 44 39 08 00 00 00 00   	movq	$0x0, 0x8(%rcx,%rdi)
    1ca9: 48 c7 04 39 00 00 00 00      	movq	$0x0, (%rcx,%rdi)
; ./drivers/net/ethernet/mellanox/mlx5/core/en/txrx.h:131
; 	cseg->opmod_idx_opcode = cpu_to_be32((*pc << 8) | MLX5_OPCODE_NOP);
    1cb1: 44 0f b7 43 44               	movzwl	0x44(%rbx), %r8d
    1cb6: 66 41 c1 c0 08               	rolw	$0x8, %r8w
    1cbb: 45 0f b7 c0                  	movzwl	%r8w, %r8d
    1cbf: 41 c1 e0 08                  	shll	$0x8, %r8d
    1cc3: 44 89 04 39                  	movl	%r8d, (%rcx,%rdi)
; ./drivers/net/ethernet/mellanox/mlx5/core/en/txrx.h:132
; 	cseg->qpn_ds           = cpu_to_be32((sqn << 8) | 0x01);
    1cc7: 41 c1 e1 08                  	shll	$0x8, %r9d
    1ccb: 41 83 c9 01                  	orl	$0x1, %r9d
    1ccf: 41 0f c9                     	bswapl	%r9d
    1cd2: 44 89 4c 39 04               	movl	%r9d, 0x4(%rcx,%rdi)
; ./drivers/net/ethernet/mellanox/mlx5/core/en/txrx.h:134
; 	(*pc)++;
    1cd7: 66 ff 43 44                  	incw	0x44(%rbx)
; ./drivers/net/ethernet/mellanox/mlx5/core/en/xdp.c:347
; 		for (; wi < edge_wi; wi++) {
    1cdb: 48 83 c0 02                  	addq	$0x2, %rax
    1cdf: 48 39 f0                     	cmpq	%rsi, %rax
    1ce2: 0f 82 68 ff ff ff            	jb	0x1c50 <mlx5e_xmit_xdp_frame_mpwqe+0x320>
; ./drivers/net/ethernet/mellanox/mlx5/core/en/xdp.c:354
; 		sq->stats->nops += contig_wqebbs;
    1ce8: 48 8b 8b 30 02 00 00         	movq	0x230(%rbx), %rcx
    1cef: 48 01 51 18                  	addq	%rdx, 0x18(%rcx)
; ./drivers/net/ethernet/mellanox/mlx5/core/wq.h:159
; 	return mlx5_frag_buf_get_wqe(&wq->fbc, ix);
    1cf3: 0f b7 43 44                  	movzwl	0x44(%rbx), %eax
; ./drivers/net/ethernet/mellanox/mlx5/core/en/xdp.c:356
; 		pi = mlx5_wq_cyc_ctr2ix(wq, sq->pc);
    1cf7: 0f b7 8b 10 02 00 00         	movzwl	0x210(%rbx), %ecx
; ./drivers/net/ethernet/mellanox/mlx5/core/wq.h:144
; 	return ctr & wq->fbc.sz_m1;
    1cfe: 21 c1                        	andl	%eax, %ecx
; ././include/linux/mlx5/driver.h:950
; 	ix  += fbc->strides_offset;
    1d00: 0f b7 bb 16 02 00 00         	movzwl	0x216(%rbx), %edi
    1d07: 01 cf                        	addl	%ecx, %edi
; ././include/linux/mlx5/driver.h:953
; 	return fbc->frags[frag].buf + ((fbc->frag_sz_m1 & ix) << fbc->log_stride);
    1d09: 0f b7 b3 14 02 00 00         	movzwl	0x214(%rbx), %esi
    1d10: e9 bf fc ff ff               	jmp	0x19d4 <mlx5e_xmit_xdp_frame_mpwqe+0xa4>
; ./drivers/net/ethernet/mellanox/mlx5/core/en/xdp.c:452
; 				mlx5e_xdp_mpwqe_complete(sq);
    1d15: 48 89 df                     	movq	%rbx, %rdi
    1d18: e8 00 00 00 00               	callq	0x1d1d <mlx5e_xmit_xdp_frame_mpwqe+0x3ed>
		0000000000001d19:  R_X86_64_PLT32	mlx5e_xdp_mpwqe_complete-0x4
    1d1d: e9 f0 fd ff ff               	jmp	0x1b12 <mlx5e_xmit_xdp_frame_mpwqe+0x1e2>
    1d22: 66 66 66 66 66 2e 0f 1f 84 00 00 00 00 00    	nopw	%cs:(%rax,%rax)

