Return-Path: <bpf+bounces-3253-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A5DB73B5E4
	for <lists+bpf@lfdr.de>; Fri, 23 Jun 2023 13:12:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B322E281692
	for <lists+bpf@lfdr.de>; Fri, 23 Jun 2023 11:12:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D27B230F3;
	Fri, 23 Jun 2023 11:12:26 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F96E17EA
	for <bpf@vger.kernel.org>; Fri, 23 Jun 2023 11:12:26 +0000 (UTC)
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 551C12113
	for <bpf@vger.kernel.org>; Fri, 23 Jun 2023 04:12:23 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id ffacd0b85a97d-311394406d0so500497f8f.2
        for <bpf@vger.kernel.org>; Fri, 23 Jun 2023 04:12:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brouer-com.20221208.gappssmtp.com; s=20221208; t=1687518742; x=1690110742;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:cc:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ya89jZy41fZuCej14Q/drVkMBb/gIlPbi2gQGlwLsvs=;
        b=CdQoE1ABHT30tNlFfZB3ujGAtkRfaBt16sC/cfDVLZIEwRSBtBqxG6SI6+cRb4rYVE
         hV4Uhqfz8cjE8EOUHSXSC69ZiWQr9TTBY8CyTBhEI/qfUXSVaNTWr/c3tOS06oZKFYJa
         AYjMBEz2n3Q9l7CNRxXrzTh24P8DUdIadeg2bglGFcrGkQqkOVbPuQKMVkOJ7PZX3FUQ
         iGsBYFUnRH9/c4bQ1U5pFv05YRtnTeS7o0+9x9a4r+CrekXeJSbXqJdPTzm6kYefvq+j
         WMzavM+No0M+aui/vNy9KcE0Lw3j2QYN8JLyIC7WBv9tEvt5Ju9PZWy79uZR9sErkALx
         PiaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687518742; x=1690110742;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:cc:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ya89jZy41fZuCej14Q/drVkMBb/gIlPbi2gQGlwLsvs=;
        b=WbqMYeiBuF3cm232rhUKdHV3IyTeDijVjfe99G3v2/Xd8s/f+jd/AH1QOjDT0H8zhY
         bxmtls3CbBETP3LoCsf+87Whwy39VFeKYIi9CwUqUIAL/RUMkE6MZSPw0CaAFk2kEV1n
         3wTp/xZve3UpaA2y17rIGMCJOrwSXtmetEmWDVpHt5NqHzZtpewIS0Y31dr4IFZvYXsV
         M8vKPpKLyul8GAEVy6+Cii+E1WpfdNurFxPNy8MsXyY6Q1SUPtdFeZdgJ4YW5ojXzwdp
         WpnPdxi825UNWizk02LtgKpycPvLQp3Kf9mKoC5GClOBCSOcRcmIqmj6enMpJzjR3o3+
         J0cg==
X-Gm-Message-State: AC+VfDwI/HPe3US/Je2NHOkYw7lnUo7joBsvf2alW2gilXZN0PyqO+2Z
	MIpIYTdHwFXqXgBvM6C2mYFtSA==
X-Google-Smtp-Source: ACHHUZ5S07lZ5zx2+dXQh1Nn0MTmmwrkcaSV7HjODHG0LCAu3aTMgwhexVeFgSfejG2SrUTZzBWMyA==
X-Received: by 2002:a5d:650b:0:b0:30f:b3d1:8f99 with SMTP id x11-20020a5d650b000000b0030fb3d18f99mr14313926wru.38.1687518741592;
        Fri, 23 Jun 2023 04:12:21 -0700 (PDT)
Received: from [192.168.42.222] (194-45-78-10.static.kviknet.net. [194.45.78.10])
        by smtp.gmail.com with ESMTPSA id h17-20020a5d6891000000b0030497b3224bsm9374010wru.64.2023.06.23.04.12.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Jun 2023 04:12:21 -0700 (PDT)
Message-ID: <a50de565-23a7-2ac5-d5cb-e568e3ad77c9@brouer.com>
Date: Fri, 23 Jun 2023 13:12:19 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Cc: brouer@redhat.com, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, martin.lau@linux.dev, song@kernel.org, yhs@fb.com,
 john.fastabend@gmail.com, kpsingh@kernel.org, haoluo@google.com,
 jolsa@kernel.org, netdev@vger.kernel.org,
 "xdp-hints@xdp-project.net" <xdp-hints@xdp-project.net>
Subject: Re: [RFC bpf-next v2 09/11] selftests/bpf: Extend xdp_metadata with
 devtx kfuncs
Content-Language: en-US
To: Stanislav Fomichev <sdf@google.com>, bpf@vger.kernel.org
References: <20230621170244.1283336-1-sdf@google.com>
 <20230621170244.1283336-10-sdf@google.com>
From: "Jesper D. Brouer" <netdev@brouer.com>
In-Reply-To: <20230621170244.1283336-10-sdf@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 21/06/2023 19.02, Stanislav Fomichev wrote:
> Attach kfuncs that request and report TX timestamp via ringbuf.
> Confirm on the userspace side that the program has triggered
> and the timestamp is non-zero.
> 
> Also make sure devtx_frame has a sensible pointers and data.
> 
[...]


> diff --git a/tools/testing/selftests/bpf/progs/xdp_metadata.c b/tools/testing/selftests/bpf/progs/xdp_metadata.c
> index d151d406a123..fc025183d45a 100644
> --- a/tools/testing/selftests/bpf/progs/xdp_metadata.c
> +++ b/tools/testing/selftests/bpf/progs/xdp_metadata.c
[...]
> @@ -19,10 +24,25 @@ struct {
>   	__type(value, __u32);
>   } prog_arr SEC(".maps");
>   
> +struct {
> +	__uint(type, BPF_MAP_TYPE_RINGBUF);
> +	__uint(max_entries, 10);
> +} tx_compl_buf SEC(".maps");
> +
> +__u64 pkts_fail_tx = 0;
> +
> +int ifindex = -1;
> +__u64 net_cookie = -1;
> +
>   extern int bpf_xdp_metadata_rx_timestamp(const struct xdp_md *ctx,
>   					 __u64 *timestamp) __ksym;
>   extern int bpf_xdp_metadata_rx_hash(const struct xdp_md *ctx, __u32 *hash,
>   				    enum xdp_rss_hash_type *rss_type) __ksym;
> +extern int bpf_devtx_sb_request_timestamp(const struct devtx_frame *ctx) __ksym;
> +extern int bpf_devtx_cp_timestamp(const struct devtx_frame *ctx, __u64 *timestamp) __ksym;
> +
> +extern int bpf_devtx_sb_attach(int ifindex, int prog_fd) __ksym;
> +extern int bpf_devtx_cp_attach(int ifindex, int prog_fd) __ksym;
>   
>   SEC("xdp")
>   int rx(struct xdp_md *ctx)
> @@ -61,4 +81,102 @@ int rx(struct xdp_md *ctx)
>   	return bpf_redirect_map(&xsk, ctx->rx_queue_index, XDP_PASS);
>   }
>   
> +static inline int verify_frame(const struct devtx_frame *frame)
> +{
> +	struct ethhdr eth = {};
> +
> +	/* all the pointers are set up correctly */
> +	if (!frame->data)
> +		return -1;
> +	if (!frame->sinfo)
> +		return -1;
> +
> +	/* can get to the frags */
> +	if (frame->sinfo->nr_frags != 0)
> +		return -1;
> +	if (frame->sinfo->frags[0].bv_page != 0)
> +		return -1;
> +	if (frame->sinfo->frags[0].bv_len != 0)
> +		return -1;
> +	if (frame->sinfo->frags[0].bv_offset != 0)
> +		return -1;
> +
> +	/* the data has something that looks like ethernet */
> +	if (frame->len != 46)
> +		return -1;
> +	bpf_probe_read_kernel(&eth, sizeof(eth), frame->data);
> +
> +	if (eth.h_proto != bpf_htons(ETH_P_IP))
> +		return -1;
> +
> +	return 0;
> +}
> +
> +SEC("fentry/veth_devtx_submit")
> +int BPF_PROG(tx_submit, const struct devtx_frame *frame)
> +{
> +	struct xdp_tx_meta meta = {};
> +	int ret;
> +
> +	if (frame->netdev->ifindex != ifindex)
> +		return 0;
> +	if (frame->netdev->nd_net.net->net_cookie != net_cookie)
> +		return 0;
> +	if (frame->meta_len != TX_META_LEN)
> +		return 0;
> +
> +	bpf_probe_read_kernel(&meta, sizeof(meta), frame->data - TX_META_LEN);
> +	if (!meta.request_timestamp)
> +		return 0;
> +
> +	ret = verify_frame(frame);
> +	if (ret < 0) {
> +		__sync_add_and_fetch(&pkts_fail_tx, 1);
> +		return 0;
> +	}
> +
> +	ret = bpf_devtx_sb_request_timestamp(frame);

My original design thoughts were that BPF-progs would write into
metadata area, with the intend that at TX-complete we can access this
metadata area again.

In this case with request_timestamp it would make sense to me, to store
a sequence number (+ the TX-queue number), such that program code can
correlate on complete event.

Like xdp_hw_metadata example, I would likely also to add a software 
timestamp, what I could check at TX complete hook.

> +	if (ret < 0) {
> +		__sync_add_and_fetch(&pkts_fail_tx, 1);
> +		return 0;
> +	}
> +
> +	return 0;
> +}
> +
> +SEC("fentry/veth_devtx_complete")
> +int BPF_PROG(tx_complete, const struct devtx_frame *frame)
> +{
> +	struct xdp_tx_meta meta = {};
> +	struct devtx_sample *sample;
> +	int ret;
> +
> +	if (frame->netdev->ifindex != ifindex)
> +		return 0;
> +	if (frame->netdev->nd_net.net->net_cookie != net_cookie)
> +		return 0;
> +	if (frame->meta_len != TX_META_LEN)
> +		return 0;
> +
> +	bpf_probe_read_kernel(&meta, sizeof(meta), frame->data - TX_META_LEN);
> +	if (!meta.request_timestamp)
> +		return 0;
> +
> +	ret = verify_frame(frame);
> +	if (ret < 0) {
> +		__sync_add_and_fetch(&pkts_fail_tx, 1);
> +		return 0;
> +	}
> +
> +	sample = bpf_ringbuf_reserve(&tx_compl_buf, sizeof(*sample), 0);
> +	if (!sample)
> +		return 0;

Sending this via a ringbuffer to userspace, will make it hard to
correlate. (For AF_XDP it would help a little to add the TX-queue
number, as this hook isn't queue bound but AF_XDP is).

> +
> +	sample->timestamp_retval = bpf_devtx_cp_timestamp(frame, &sample->timestamp);
> +

I were expecting to see, information being written into the metadata 
area of the frame, such that AF_XDP completion-queue handling can 
extract this obtained timestamp.


> +	bpf_ringbuf_submit(sample, 0);
> +
> +	return 0;
> +}
> +
>   char _license[] SEC("license") = "GPL";
> diff --git a/tools/testing/selftests/bpf/xdp_metadata.h b/tools/testing/selftests/bpf/xdp_metadata.h
> index 938a729bd307..e410f2b95e64 100644
> --- a/tools/testing/selftests/bpf/xdp_metadata.h
> +++ b/tools/testing/selftests/bpf/xdp_metadata.h
> @@ -18,3 +18,17 @@ struct xdp_meta {
>   		__s32 rx_hash_err;
>   	};
>   };
> +
> +struct devtx_sample {
> +	int timestamp_retval;
> +	__u64 timestamp;
> +};
> +
> +#define TX_META_LEN	8

Very static design.

> +
> +struct xdp_tx_meta {
> +	__u8 request_timestamp;
> +	__u8 padding0;
> +	__u16 padding1;
> +	__u32 padding2;
> +};

padding2 could be a btf_id for creating a more flexible design.

--Jesper

