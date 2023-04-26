Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D0346EEF65
	for <lists+bpf@lfdr.de>; Wed, 26 Apr 2023 09:38:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239654AbjDZHiC (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 26 Apr 2023 03:38:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239381AbjDZHiB (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 26 Apr 2023 03:38:01 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E00F3581
        for <bpf@vger.kernel.org>; Wed, 26 Apr 2023 00:37:59 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id a640c23a62f3a-95316faa3a8so1268157966b.2
        for <bpf@vger.kernel.org>; Wed, 26 Apr 2023 00:37:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682494678; x=1685086678;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8i3FKHlDifIZDSUlM3GadQoCcX5it8Xz2TYPfoDVKpY=;
        b=g+0KtpMCdlGE8XjwW1LdxQipayi8+YepN9Y3kutlgSsJ/jY1dCVnOE771dWeA1KgYf
         wF9mnneDcyVWpFkxZo5f6Bzpg4KJ/mj+z2ZrupaO5WJZEGHZURJo4BH5CNhsuYXpFSv1
         8igglM21K81AvsDzE5IIZsDNMNWIEpsSZeijybbYdtH33sNv9ZEiVpzf1YO/tIb7G8qv
         iOClSZCpoO14k5/kBf827eUDsjZf2Yo4ZeCbggAPVGiidQfNLUHCW+fjMrPzoPDw3ybt
         EZCwM6T4gKjXbMdVmgzWykzgZo17l9I2LDEzYo9kSlJhIO34uCDF6NUkT3TCImt2tD7m
         NZbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682494678; x=1685086678;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8i3FKHlDifIZDSUlM3GadQoCcX5it8Xz2TYPfoDVKpY=;
        b=gLuv+4lZPK6mN5AIv0LhZ5IIX4o05TMa5/ztTTet98d750y8EI/Gmd2apR+HwrTMiN
         X/Pt3PyxWYwbERmTNSVYNx9ZVrdIIF3lNTHKl52at6YucEgrFnQQXOVWagDyLIfcXMPB
         k4Pt24xawJeRVtH2pcrshF9WjpRgmlVjw5emFK+8LI9dHZBXOBh+clgADYLL4blHmQ9s
         sruU3QNqEA4V6Z6Edh8zC8nVgop7/647bJO8BWwpOU+towOdOPjHUbHm8jbe3MT82IE6
         lVRu5zg/6OlOLgf9L+LrFoNEgro+48F9xXLww77B3Wbz2X9tOm1Yg2WBXUs48yNVRxyZ
         4LVw==
X-Gm-Message-State: AAQBX9dSadkCd29wlXWwi4K3rgwxRnTAKJsfyENMPTnSQob7gAIJgbOp
        8nd/Y8v+WDJ28Hvkqcm5Jj8=
X-Google-Smtp-Source: AKy350ZJznRxr/2gBAljDLYsxDVET0mmUSt2ombNwNw88LAeEqYK990xlXLRcxKk54jBl28/Sc0adA==
X-Received: by 2002:a17:906:3b56:b0:94f:cc7:fd7f with SMTP id h22-20020a1709063b5600b0094f0cc7fd7fmr16199135ejf.65.1682494677652;
        Wed, 26 Apr 2023 00:37:57 -0700 (PDT)
Received: from krava (2001-1ae9-1c2-4c00-726e-c10f-8833-ff22.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:726e:c10f:8833:ff22])
        by smtp.gmail.com with ESMTPSA id x10-20020a1709064bca00b0095334355a34sm7795034ejv.96.2023.04.26.00.37.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Apr 2023 00:37:57 -0700 (PDT)
From:   Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date:   Wed, 26 Apr 2023 09:37:55 +0200
To:     Yonghong Song <yhs@meta.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: Re: [RFC/PATCH bpf-next 01/20] bpf: Add multi uprobe link
Message-ID: <ZEjU0ykZZTHMVlZt@krava>
References: <20230424160447.2005755-1-jolsa@kernel.org>
 <20230424160447.2005755-2-jolsa@kernel.org>
 <d7e22ae7-0080-1ad3-e05b-379890953f95@meta.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d7e22ae7-0080-1ad3-e05b-379890953f95@meta.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Apr 25, 2023 at 04:56:00PM -0700, Yonghong Song wrote:
> 
> 
> On 4/24/23 9:04 AM, Jiri Olsa wrote:
> > Adding new multi uprobe link that allows to attach bpf program
> > to multiple uprobes.
> > 
> > Uprobes to attach are specified via new link_create uprobe_multi
> > union:
> > 
> >    struct {
> >            __u32           flags;
> >            __u32           cnt;
> >            __aligned_u64   paths;
> >            __aligned_u64   offsets;
> >            __aligned_u64   ref_ctr_offsets;
> >    } uprobe_multi;
> > 
> > Uprobes are defined in paths/offsets/ref_ctr_offsets arrays with
> > the same 'cnt' length. Each uprobe is defined with a single index
> > in all three arrays:
> > 
> >    paths[idx], offsets[idx] and/or ref_ctr_offsets[idx]
> 
> paths[idx], offsets[idx] and optional ref_ctr_offsets[idx]?

yes

> 
> > 
> > The 'flags' supports single bit for now that marks the uprobe as
> > return probe.
> > 
> > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> > ---
> >   include/linux/trace_events.h |   6 +
> >   include/uapi/linux/bpf.h     |  14 +++
> >   kernel/bpf/syscall.c         |  16 ++-
> >   kernel/trace/bpf_trace.c     | 231 +++++++++++++++++++++++++++++++++++
> >   4 files changed, 265 insertions(+), 2 deletions(-)
> > 
> > diff --git a/include/linux/trace_events.h b/include/linux/trace_events.h
> > index 0e373222a6df..b0db245fc0f5 100644
> > --- a/include/linux/trace_events.h
> > +++ b/include/linux/trace_events.h
> > @@ -749,6 +749,7 @@ int bpf_get_perf_event_info(const struct perf_event *event, u32 *prog_id,
> >   			    u32 *fd_type, const char **buf,
> >   			    u64 *probe_offset, u64 *probe_addr);
> >   int bpf_kprobe_multi_link_attach(const union bpf_attr *attr, struct bpf_prog *prog);
> > +int bpf_uprobe_multi_link_attach(const union bpf_attr *attr, struct bpf_prog *prog);
> >   #else
> >   static inline unsigned int trace_call_bpf(struct trace_event_call *call, void *ctx)
> >   {
> > @@ -795,6 +796,11 @@ bpf_kprobe_multi_link_attach(const union bpf_attr *attr, struct bpf_prog *prog)
> >   {
> >   	return -EOPNOTSUPP;
> >   }
> > +static inline int
> > +bpf_uprobe_multi_link_attach(const union bpf_attr *attr, struct bpf_prog *prog)
> > +{
> > +	return -EOPNOTSUPP;
> > +}
> >   #endif
> >   enum {
> > diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> > index 1bb11a6ee667..debc041c6ca5 100644
> > --- a/include/uapi/linux/bpf.h
> > +++ b/include/uapi/linux/bpf.h
> > @@ -1035,6 +1035,7 @@ enum bpf_attach_type {
> >   	BPF_TRACE_KPROBE_MULTI,
> >   	BPF_LSM_CGROUP,
> >   	BPF_STRUCT_OPS,
> > +	BPF_TRACE_UPROBE_MULTI,
> >   	__MAX_BPF_ATTACH_TYPE
> >   };
> > @@ -1052,6 +1053,7 @@ enum bpf_link_type {
> >   	BPF_LINK_TYPE_KPROBE_MULTI = 8,
> >   	BPF_LINK_TYPE_STRUCT_OPS = 9,
> >   	BPF_LINK_TYPE_NETFILTER = 10,
> > +	BPF_LINK_TYPE_UPROBE_MULTI = 11,
> >   	MAX_BPF_LINK_TYPE,
> >   };
> > @@ -1169,6 +1171,11 @@ enum bpf_link_type {
> >    */
> >   #define BPF_F_KPROBE_MULTI_RETURN	(1U << 0)
> > +/* link_create.uprobe_multi.flags used in LINK_CREATE command for
> > + * BPF_TRACE_UPROBE_MULTI attach type to create return probe.
> > + */
> > +#define BPF_F_UPROBE_MULTI_RETURN	(1U << 0)
> > +
> >   /* When BPF ldimm64's insn[0].src_reg != 0 then this can have
> >    * the following extensions:
> >    *
> > @@ -1568,6 +1575,13 @@ union bpf_attr {
> >   				__s32		priority;
> >   				__u32		flags;
> >   			} netfilter;
> > +			struct {
> > +				__u32		flags;
> > +				__u32		cnt;
> > +				__aligned_u64	paths;
> > +				__aligned_u64	offsets;
> > +				__aligned_u64	ref_ctr_offsets;
> > +			} uprobe_multi;
> >   		};
> >   	} link_create;
> > diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> > index 14f39c1e573e..0b789a33317b 100644
> > --- a/kernel/bpf/syscall.c
> > +++ b/kernel/bpf/syscall.c
> > @@ -4601,7 +4601,8 @@ static int link_create(union bpf_attr *attr, bpfptr_t uattr)
> >   		break;
> >   	case BPF_PROG_TYPE_KPROBE:
> >   		if (attr->link_create.attach_type != BPF_PERF_EVENT &&
> > -		    attr->link_create.attach_type != BPF_TRACE_KPROBE_MULTI) {
> > +		    attr->link_create.attach_type != BPF_TRACE_KPROBE_MULTI &&
> > +		    attr->link_create.attach_type != BPF_TRACE_UPROBE_MULTI) {
> >   			ret = -EINVAL;
> >   			goto out;
> >   		}
> > @@ -4666,10 +4667,21 @@ static int link_create(union bpf_attr *attr, bpfptr_t uattr)
> >   		ret = bpf_perf_link_attach(attr, prog);
> >   		break;
> >   	case BPF_PROG_TYPE_KPROBE:
> > +		/* Ensure that program with eBPF_TRACE_UPROBE_MULTI attach type can
> > +		 * attach only to uprobe_multi link. It has its own runtime context
> > +		 * which is specific for get_func_ip/get_attach_cookie helpers.
> > +		 */
> > +		if (prog->expected_attach_type == BPF_TRACE_UPROBE_MULTI &&
> > +		    attr->link_create.attach_type != BPF_TRACE_UPROBE_MULTI) {
> > +			ret = -EINVAL;
> > +			goto out;
> > +		}
> 
> The above seems redundant since it is checked in
> bpf_uprobe_multi_link_attach().
> That is why the BPF_TRACE_KPROBE_MULTI is not checked here since
> bpf_kprobe_multi_link_attach() checks it.

for standard kprobe type program we do not check expected_attach_type,
but get_func_ip/get_attach_cookie helpers functions are picked based on
that:

        case BPF_FUNC_get_attach_cookie:
                if (prog->expected_attach_type == BPF_TRACE_KPROBE_MULTI)
                        return &bpf_get_attach_cookie_proto_kmulti;
                if (prog->expected_attach_type == BPF_TRACE_UPROBE_MULTI)
                        return &bpf_get_attach_cookie_proto_umulti;
                return &bpf_get_attach_cookie_proto_trace;

so standard kprobe attached through BPF_PERF_EVENT would run BPF_TRACE_UPROBE_MULTI
version of the helper and crash, because there's different context used

it's probably a problem for kprobe_multi as well, I'll check and have
separate patch for that

> > +static void bpf_uprobe_multi_link_dealloc(struct bpf_link *link)
> > +{
> > +	struct bpf_uprobe_multi_link *umulti_link;
> > +
> > +	umulti_link = container_of(link, struct bpf_uprobe_multi_link, link);
> > +	kvfree(umulti_link->uprobes);
> > +	kfree(umulti_link);
> > +}
> > +
> > +static const struct bpf_link_ops bpf_uprobe_multi_link_lops = {
> > +	.release = bpf_uprobe_multi_link_release,
> > +	.dealloc = bpf_uprobe_multi_link_dealloc,
> > +};
> > +
> > +static int uprobe_prog_run(struct bpf_uprobe *uprobe,
> > +			   unsigned long entry_ip,
> > +			   struct pt_regs *regs)
> > +{
> > +	struct bpf_uprobe_multi_link *link = uprobe->link;
> > +	struct bpf_uprobe_multi_run_ctx run_ctx = {
> > +		.entry_ip = entry_ip,
> > +	};
> > +	struct bpf_run_ctx *old_run_ctx;
> > +	int err;
> > +
> > +	preempt_disable();
> 
> Alexei has pointed out here.
> preempt_disable() is not favored.
> We should use migrate_disable/enable().
> For non sleepable program, the below rcu_read_lock() is okay.
> For sleepable program, use rcu_read_lock_trace().
> See __bpf_prog_enter_sleepable_recur() in trampoline.c as
> an example.

yes, I'll fix that

thanks,
jirka
