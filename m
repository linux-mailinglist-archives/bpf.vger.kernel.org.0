Return-Path: <bpf+bounces-13286-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 138B87D7A02
	for <lists+bpf@lfdr.de>; Thu, 26 Oct 2023 03:16:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9E426B21311
	for <lists+bpf@lfdr.de>; Thu, 26 Oct 2023 01:16:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCD544426;
	Thu, 26 Oct 2023 01:15:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gREAeIR1"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A68E615C3;
	Thu, 26 Oct 2023 01:15:50 +0000 (UTC)
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com [IPv6:2607:f8b0:4864:20::b2b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1374BD;
	Wed, 25 Oct 2023 18:15:48 -0700 (PDT)
Received: by mail-yb1-xb2b.google.com with SMTP id 3f1490d57ef6-d9ca471cf3aso237006276.2;
        Wed, 25 Oct 2023 18:15:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698282948; x=1698887748; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DVb1DA+IDrKcthxg2mOX6OIL1LqoMa3HS23gAOIf1ZQ=;
        b=gREAeIR1HEXNALteq+jF0ZwPsyQSL9z6myl0N+21/Ni+ML8q5GmcZ1zxdbPXEAj+9k
         zfvmOmiz/elVk+dGCvYwmWWTd6ISIAgy3mJTRTni6uf9YZDsXgsu6DWJ5dQflFLD0PSt
         EM54e9QYeqQldVhUQbkn+iYyijH3Cdc4HTDuPrutvuN3wCACZzHVwO+bvwLBX11RiRhu
         6qgbZqAdZu/+rd4CvZGyCy/tWw6oo3bPrvjPZ9KW6na95q3eNzy3MEGgJwr7VsGgH8ce
         GcsR1Rt82ZOtaoPs3x/2dkG0ta/c5OGiQAw8uNKDio0Bc5bQd1zuA/wOQSNIgvl0NClf
         29EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698282948; x=1698887748;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DVb1DA+IDrKcthxg2mOX6OIL1LqoMa3HS23gAOIf1ZQ=;
        b=Tr4rY/BczwsWibiPrhPsCRphYnV/USwmnPIMgCjNulNRo9ZPONmWjfQbwG1XDydhzf
         34+xveY8MEJFh3T7bODJc+RL9dc80kJfTvbxjURfNMJlLYFKQxi0+hb1vF3pzm3mFqmq
         vBV+7qziZ9Jk7+CHkBDJd9cnmcTHcaj/E/T+kiH0wwx04CmUq7OGtH04VBJeNj3yC7G4
         e+WIOqw5TXwIkZyhXoTLc5q9HQbVcrBEYwMcHKWYdfevVoVpa9v5QZqDM9ZKb7/a/sRv
         QyDYqv/1vcMUj5ggJdZg3pXEUEEAged9HZR7kJ+KTc/CYW+cm0M4VCzuXCVr7k4e6LzA
         CpdQ==
X-Gm-Message-State: AOJu0Yy0F1wmdrwpoKdEmyDnMTV7vTlDmc0a5kO2yVYOAjJ/T6yfB1iB
	eTRdEzeabm2DtK3RF61aw/I=
X-Google-Smtp-Source: AGHT+IHbYaAR3dAu0oYSQhRl+YtN8EIaKD26mqfBIEEY6cMIKOiRbYh24PTQe6CzxWabLgBLkqp45Q==
X-Received: by 2002:a81:54d5:0:b0:59f:4bc3:3e9 with SMTP id i204-20020a8154d5000000b0059f4bc303e9mr16553263ywb.46.1698282948065;
        Wed, 25 Oct 2023 18:15:48 -0700 (PDT)
Received: from ?IPV6:2600:1700:6cf8:1240:1545:3e11:ea38:83fe? ([2600:1700:6cf8:1240:1545:3e11:ea38:83fe])
        by smtp.gmail.com with ESMTPSA id h6-20020a0df706000000b00579e5c4982fsm5550345ywf.36.2023.10.25.18.15.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Oct 2023 18:15:47 -0700 (PDT)
Message-ID: <7e2b81d6-b154-446e-b074-1a8dc6426ce7@gmail.com>
Date: Wed, 25 Oct 2023 18:15:46 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v4 1/7] netkit, bpf: Add bpf programmable net
 device
Content-Language: en-US
To: Martin KaFai Lau <martin.lau@linux.dev>
Cc: netdev@vger.kernel.org, razor@blackwall.org, ast@kernel.org,
 andrii@kernel.org, john.fastabend@gmail.com, sdf@google.com,
 toke@kernel.org, kuba@kernel.org, andrew@lunn.ch,
 =?UTF-8?Q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
 Daniel Borkmann <daniel@iogearbox.net>, bpf@vger.kernel.org
References: <20231024214904.29825-1-daniel@iogearbox.net>
 <20231024214904.29825-2-daniel@iogearbox.net>
 <ad801a2c-217e-44b4-8dae-0ae7b1b8484f@gmail.com>
 <51abec01-c4ce-434f-694a-f932e0e203ec@linux.dev>
From: Kui-Feng Lee <sinquersw@gmail.com>
In-Reply-To: <51abec01-c4ce-434f-694a-f932e0e203ec@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 10/25/23 15:09, Martin KaFai Lau wrote:
> On 10/25/23 2:24 PM, Kui-Feng Lee wrote:
>>
>>
>> On 10/24/23 14:48, Daniel Borkmann wrote:
>>> This work adds a new, minimal BPF-programmable device called "netkit"
>>> (former PoC code-name "meta") we recently presented at LSF/MM/BPF. The
>>> core idea is that BPF programs are executed within the drivers xmit 
>>> routine
>>> and therefore e.g. in case of containers/Pods moving BPF processing 
>>> closer
>>> to the source.
>>>
>>
>> Sorry for intruding into this discussion! Although it is too late to
>> mentioned this since this patchset have been v4 already.
>>
>> I notice netkit has introduced a new attach type. I wonder if it
>> possible to implement it as a new struct_ops type.
> 
> Could your elaborate more about what does this struct_ops type do and 
> how is it different from the SCHED_CLS bpf prog that the netkit is running?

I found the code has been landed.
Basing on the landed code and
the patchset of registering bpf struct_ops from modules that I
am working on, it will looks like what is done in following patch.
No changes on syscall, uapi and libbpf are required.


diff --git a/drivers/net/netkit.c b/drivers/net/netkit.c
index 7e484f9fd3ae..e4eafaf397bf 100644
--- a/drivers/net/netkit.c
+++ b/drivers/net/netkit.c
@@ -20,6 +20,7 @@ struct netkit {
  	struct bpf_mprog_entry __rcu *active;
  	enum netkit_action policy;
  	struct bpf_mprog_bundle	bundle;
+	struct hlist_head ops_list;

  	/* Needed in slow-path */
  	enum netkit_mode mode;
@@ -27,6 +28,13 @@ struct netkit {
  	u32 headroom;
  };

+struct netkit_ops {
+	struct hlist_node node;
+	int ifindex;
+
+	int (*xmit)(struct sk_buff *skb);
+};
+
  struct netkit_link {
  	struct bpf_link link;
  	struct net_device *dev;
@@ -46,6 +54,22 @@ netkit_run(const struct bpf_mprog_entry *entry, 
struct sk_buff *skb,
  		if (ret != NETKIT_NEXT)
  			break;
  	}
+
+	return ret;
+}
+
+static __always_inline int
+netkit_run_st_ops(const struct netkit *nk, struct sk_buff *skb,
+	   enum netkit_action ret)
+{
+	struct netkit_ops *ops;
+
+	hlist_for_each_entry_rcu(ops, &nk->ops_list, node) {
+		ret = ops->xmit(skb);
+		if (ret != NETKIT_NEXT)
+			break;
+	}
+
  	return ret;
  }

@@ -80,6 +104,8 @@ static netdev_tx_t netkit_xmit(struct sk_buff *skb, 
struct net_device *dev)
  	entry = rcu_dereference(nk->active);
  	if (entry)
  		ret = netkit_run(entry, skb, ret);
+	if (ret == NETKIT_NEXT)
+		ret = netkit_run_st_ops(nk, skb, ret);
  	switch (ret) {
  	case NETKIT_NEXT:
  	case NETKIT_PASS:
@@ -900,6 +926,78 @@ static const struct nla_policy 
netkit_policy[IFLA_NETKIT_MAX + 1] = {
  					    .reject_message = "Primary attribute is read-only" },
  };

+#ifdef CONFIG_DEBUG_INFO_BTF_MODULES
+
+static bool bpf_netkit_ops_is_valid_access(int off, int size,
+					   enum bpf_access_type type,
+					   const struct bpf_prog *prog,
+					   struct bpf_insn_access_aux *info)
+{
+	return bpf_tracing_btf_ctx_access(off, size, type, prog, info);
+}
+
+static const struct bpf_verifier_ops bpf_netkit_verifier_ops = {
+	.is_valid_access = bpf_netkit_ops_is_valid_access,
+};
+
+static int bpf_netkit_ops_reg(void *kdata)
+{
+	struct netkit_ops *ops = kdata;
+	struct netkit_link *nkl;
+	struct net_device *dev;
+
+	BTF_STRUCT_OPS_TYPE_EMIT(netkit_ops);
+	dev = netkit_dev_fetch(current->nsproxy->net_ns,
+			       ops->ifindex,
+			       BPF_NETKIT_PRIMARY);
+	nkl = netkit_link(dev);
+	hlist_add_tail_rcu(&ops->node, &nkl->ops_list);
+
+	return 0;
+}
+
+static int bpf_netkit_ops_init(struct btf *btf)
+{
+	return 0;
+}
+
+static int bpf_netkit_ops_init_member(const struct btf_type *t,
+				       const struct btf_member *member,
+				       void *kdata, const void *udata)
+{
+	struct netkit_ops *kops = kdata;
+	struct netkit_ops *uops = kdata;
+
+	u32 moff = __btf_member_bit_offset(t, member) / 8;
+	if (moff == offsetof(struct netkit_ops, ifindex)) {
+		kops->ifindex = uops->ifindex;
+		return 1;
+	}
+	if (mod < offsetof(struct netkit_ops, ifindex))
+		return 1;
+
+	return 0;
+}
+
+static void bpf_netkit_ops_unreg(void *kdata)
+{
+	struct netkit_ops *ops = kdata;
+
+	hlist_del_rcu(&ops->node);
+}
+
+struct bpf_struct_ops bpf_netkit_ops = {
+	.verifier_ops = &bpf_netkit_verifier_ops,
+	.init = bpf_netkit_ops_init,
+	.init_member = bpf_netkit_ops_init_member,
+	.reg = bpf_netkit_ops_reg,
+	.unreg = bpf_netki_ops_unreg,
+	.name = "netkit_ops",
+	.owner = THIS_MODULE,
+};
+
+#endif /* CONFIG_DEBUG_INFO_BTF_MODULES */
+
  static struct rtnl_link_ops netkit_link_ops = {
  	.kind		= DRV_NAME,
  	.priv_size	= sizeof(struct netkit),
@@ -917,17 +1015,22 @@ static struct rtnl_link_ops netkit_link_ops = {

  static __init int netkit_init(void)
  {
+	int ret;
+
  	BUILD_BUG_ON((int)NETKIT_NEXT != (int)TCX_NEXT ||
  		     (int)NETKIT_PASS != (int)TCX_PASS ||
  		     (int)NETKIT_DROP != (int)TCX_DROP ||
  		     (int)NETKIT_REDIRECT != (int)TCX_REDIRECT);

-	return rtnl_link_register(&netkit_link_ops);
+	ret = rtnl_link_register(&netkit_link_ops);
+#ifdef CONFIG_DEBUG_INFO_BTF_MODULES
+	ret = ret ?: register_bpf_struct_ops(&bpf_netkit_ops);
+#endif
  }

  static __exit void netkit_exit(void)
  {
-	rtnl_link_unregister(&netkit_link_ops);
+	rtnl_link_unregister(&bpf_netkit_ops);
  }

  module_init(netkit_init);
-- 
2.34.1

