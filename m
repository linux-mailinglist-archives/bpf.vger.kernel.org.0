Return-Path: <bpf+bounces-11083-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BE817B278C
	for <lists+bpf@lfdr.de>; Thu, 28 Sep 2023 23:30:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id B4B2C283B2C
	for <lists+bpf@lfdr.de>; Thu, 28 Sep 2023 21:30:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 693F217729;
	Thu, 28 Sep 2023 21:30:32 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B35914001;
	Thu, 28 Sep 2023 21:30:30 +0000 (UTC)
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F80FF3;
	Thu, 28 Sep 2023 14:30:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=m8sK3Zzg8Y3kMhl6zoDiScV4o6VUiMGPryZgC1qke/M=; b=OOOMWPvRb5JnoumnReDG9xvx+V
	CaydBqjpjYPr5cKNZl1lEMw/Dvbu4hT1bSBapX81sXFD+10gGKylbTypq6M9X8xcvUUMncpyqNCcf
	G0pFyxmq18dTOJCTq2Iqwq+7JVNxHnwnwkEDZQjcDqfGRIRGcdvt/WfHT4DCMzsdw/WTknxMXO90M
	EDqxd4s6bYiDalX3DARt1r3VQma0qVmCpY9qZbYRK9asIqKCZkpQNVu8BVdj3sG36CUxtXvNysDPC
	LL8pjqcm30EsxkSZeRm1BhJznSjsdX8MsS9MWS9w57PB5PKBhFWNJh9h96qEb9218VZQZhicibcjB
	DOfysf2Q==;
Received: from sslproxy05.your-server.de ([78.46.172.2])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1qlyaY-000EFT-Mq; Thu, 28 Sep 2023 23:30:26 +0200
Received: from [178.197.248.41] (helo=linux.home)
	by sslproxy05.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <daniel@iogearbox.net>)
	id 1qlyaY-000Wfn-9q; Thu, 28 Sep 2023 23:30:26 +0200
Subject: Re: [PATCH bpf-next 4/8] libbpf: Add link-based API for meta
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, martin.lau@kernel.org,
 razor@blackwall.org, ast@kernel.org, andrii@kernel.org,
 john.fastabend@gmail.com
References: <20230926055913.9859-1-daniel@iogearbox.net>
 <20230926055913.9859-5-daniel@iogearbox.net>
 <CAEf4BzbOD0CWrV39jOAR-DLUC8ntFVQKC9R92fp0o49VMJT0QQ@mail.gmail.com>
From: Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <bd6e4f9a-2bef-318b-740e-b0eea7c0a519@iogearbox.net>
Date: Thu, 28 Sep 2023 23:30:25 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAEf4BzbOD0CWrV39jOAR-DLUC8ntFVQKC9R92fp0o49VMJT0QQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.10/27045/Thu Sep 28 09:39:25 2023)
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 9/28/23 2:12 AM, Andrii Nakryiko wrote:
> On Mon, Sep 25, 2023 at 10:59 PM Daniel Borkmann <daniel@iogearbox.net> wrote:
[...]
>> +struct bpf_link *
>> +bpf_program__attach_meta(const struct bpf_program *prog, int ifindex,
>> +                        bool peer_device, const struct bpf_meta_opts *opts)
> 
> you mentioned that there are plans to also support cases where there
> is no primary-peer. Is that going to be a primary-only setup or will
> it be some third option? If the latter, should this `bool peer_device`
> be an enum then?

Agree, enum is more flexible either way, will change it to that.

>> +{
>> +       LIBBPF_OPTS(bpf_link_create_opts, link_create_opts);
>> +       enum bpf_attach_type attach_type;
>> +       __u32 relative_id;
>> +       int relative_fd;
>> +
>> +       if (!OPTS_VALID(opts, bpf_meta_opts))
>> +               return libbpf_err_ptr(-EINVAL);
>> +
>> +       relative_id = OPTS_GET(opts, relative_id, 0);
>> +       relative_fd = OPTS_GET(opts, relative_fd, 0);
>> +       attach_type = peer_device ? BPF_META_PEER : BPF_META_PRIMARY;
>> +
>> +       /* validate we don't have unexpected combinations of non-zero fields */
>> +       if (!ifindex) {
>> +               pr_warn("prog '%s': target netdevice ifindex cannot be zero\n",
>> +                       prog->name);
>> +               return libbpf_err_ptr(-EINVAL);
>> +       }
>> +       if (relative_fd && relative_id) {
>> +               pr_warn("prog '%s': relative_fd and relative_id cannot be set at the same time\n",
>> +                       prog->name);
>> +               return libbpf_err_ptr(-EINVAL);
>> +       }
>> +
>> +       link_create_opts.meta.expected_revision = OPTS_GET(opts, expected_revision, 0);
>> +       link_create_opts.meta.relative_fd = relative_fd;
>> +       link_create_opts.meta.relative_id = relative_id;
>> +       link_create_opts.flags = OPTS_GET(opts, flags, 0);
>> +
>> +       return bpf_program_attach_fd_type(prog, ifindex, "meta", attach_type,
>> +                                         &link_create_opts);
>> +}
>> +
>>   struct bpf_link *bpf_program__attach_freplace(const struct bpf_program *prog,
>>                                                int target_fd,
>>                                                const char *attach_func_name)
>> diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
>> index 0e52621cba43..827d29cf9a06 100644
>> --- a/tools/lib/bpf/libbpf.h
>> +++ b/tools/lib/bpf/libbpf.h
>> @@ -800,6 +800,21 @@ LIBBPF_API struct bpf_link *
>>   bpf_program__attach_tcx(const struct bpf_program *prog, int ifindex,
>>                          const struct bpf_tcx_opts *opts);
>>
>> +struct bpf_meta_opts {
>> +       /* size of this struct, for forward/backward compatibility */
>> +       size_t sz;
>> +       __u32 flags;
>> +       __u32 relative_fd;
>> +       __u32 relative_id;
>> +       __u64 expected_revision;
> 
> nit: move flags to be the last, so we don't have that padding before
> expected_revision?

Sounds good, will do.

>> +       size_t :0;
>> +};
>> +#define bpf_meta_opts__last_field expected_revision
>> +
>> +LIBBPF_API struct bpf_link *
>> +bpf_program__attach_meta(const struct bpf_program *prog, int ifindex,
>> +                        bool peer_device, const struct bpf_meta_opts *opts);
>> +
>>   struct bpf_map;
>>
>>   LIBBPF_API struct bpf_link *bpf_map__attach_struct_ops(const struct bpf_map *map);
>> diff --git a/tools/lib/bpf/libbpf.map b/tools/lib/bpf/libbpf.map
>> index 57712321490f..2dd4fe2cba3d 100644
>> --- a/tools/lib/bpf/libbpf.map
>> +++ b/tools/lib/bpf/libbpf.map
>> @@ -397,6 +397,7 @@ LIBBPF_1.3.0 {
>>                  bpf_obj_pin_opts;
>>                  bpf_object__unpin;
>>                  bpf_prog_detach_opts;
>> +               bpf_program__attach_meta;
>>                  bpf_program__attach_netfilter;
>>                  bpf_program__attach_tcx;
>>                  bpf_program__attach_uprobe_multi;
>> --
>> 2.34.1
>>


