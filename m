Return-Path: <bpf+bounces-8724-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 333EF7892C7
	for <lists+bpf@lfdr.de>; Sat, 26 Aug 2023 02:49:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4B7901C21047
	for <lists+bpf@lfdr.de>; Sat, 26 Aug 2023 00:49:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D499A385;
	Sat, 26 Aug 2023 00:49:17 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F57118D
	for <bpf@vger.kernel.org>; Sat, 26 Aug 2023 00:49:17 +0000 (UTC)
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88BE826B6
	for <bpf@vger.kernel.org>; Fri, 25 Aug 2023 17:49:16 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id 41be03b00d2f7-56b2e689828so864744a12.1
        for <bpf@vger.kernel.org>; Fri, 25 Aug 2023 17:49:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693010956; x=1693615756;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g42BQ3cB1i0olBbYgwxLW0vQ85qgDLVbebesrlPh3TY=;
        b=MGqF8FiI/eA9Ezh3ySZPP/ZzzMUJiM5y2EpgOh1j6bwhypp7ajan4rNDGGeNCc8TQ9
         RI4SUt19v2TGSB2yga6lCyuuJWmdSDZ4N+RerKJgEL15Ovmzz0y5tjnqCfZ+ptonaeQ3
         1jPaTTC6cXRG3zPsxqgGHZWFlwQCGjrGw2b6Pt9ps2RHRVo94Qvzn0K0QJFCuNRs2fFu
         JiSvw1s8/HUGn3XUeqGi7TgvHjgCYnY8K6lGl2ZI2siolK4Hr49ADzYAMWKA1Uc1vldB
         ULSy4SiMqclFqy+32uD7jYbxGe4W8sRgFa+62KJK2hp9F9rWJlhYEjTzm1GmctI0Ld4/
         Io/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693010956; x=1693615756;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=g42BQ3cB1i0olBbYgwxLW0vQ85qgDLVbebesrlPh3TY=;
        b=bLBAJqhfcw7cJTvcEwMdBE4JvitHJUbGTETDa8ovDNlrWomZvOxXMz989jr/rVURUA
         9BdlmNKwsOFb2wG9nGP5Dscd2ofGAoFnkpfDQAQB9iTsvKUPkjG4314am6m37YXFWObT
         rMw3QmdJW48nEpCqxcHNkOVzPfXiRWly1N4WMgOsmO7qZ6H23LWEMluZJ/uhZ4uYX11V
         aI1A/K71DKeJLhcK6XCromI/8bAIRGw5d+KEYE3Es0ZarDOeCjjv0TzBVI+f1ZAv5xk5
         veob0xWzz6/oOUkb+crI0W5+18xHJ1copbwxqocNmg3lJ+Uozu88ZerA+gCQLAIMs5Fc
         7Idw==
X-Gm-Message-State: AOJu0YzIykZqiSR3imw3KKYhUcZ0N+r9b6UiqwlweHDTyhQJhTfWpLcf
	JVJPVR/azQl1vTfmJl90HVVpyQMZoac=
X-Google-Smtp-Source: AGHT+IHXDWfm3zYwSe4O9hcyF/P88Vx0xlDrcNCuRnFV5Z2J01E0X3ILp2W4D8qdJ44tY7fPkECzWg==
X-Received: by 2002:a17:903:244e:b0:1c0:d777:3224 with SMTP id l14-20020a170903244e00b001c0d7773224mr4081903pls.50.1693010955894;
        Fri, 25 Aug 2023 17:49:15 -0700 (PDT)
Received: from localhost ([98.97.117.85])
        by smtp.gmail.com with ESMTPSA id g6-20020a170902c38600b001bdccf6b8c9sm2399694plg.127.2023.08.25.17.49.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Aug 2023 17:49:15 -0700 (PDT)
Date: Fri, 25 Aug 2023 17:49:12 -0700
From: John Fastabend <john.fastabend@gmail.com>
To: Justin Iurman <justin.iurman@uliege.be>, 
 bpf@vger.kernel.org
Cc: justin.iurman@uliege.be
Message-ID: <64e94c084c7a7_1b2e6208d@john.notmuch>
In-Reply-To: <e3783201-3b28-3661-eee3-3b5fecad0964@uliege.be>
References: <e3783201-3b28-3661-eee3-3b5fecad0964@uliege.be>
Subject: RE: [QUESTION] bpf/tc verifier error: invalid access to map value,
 min value is outside of the allowed memory range
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Justin Iurman wrote:
> Hello,
> 
> I'm facing a verifier error and don't know how to make it happy (already 
> tried lots of checks). First, here is my env:
>   - OS: Ubuntu 22.04.3 LTS
>   - kernel: 5.15.0-79-generic x86_64 (CONFIG_DEBUG_INFO_BTF=y)
>   - clang version: 14.0.0-1ubuntu1.1
>   - iproute2-5.15.0 with libbpf 0.5.0
> 
> And here is a simplified example of my program (basically, it will 
> insert in packets some bytes defined inside a map):
> 
> #include "vmlinux.h"
> #include <bpf/bpf_endian.h>
> #include <bpf/bpf_helpers.h>
> 
> #define MAX_BYTES 2048
> 
> struct xxx_t {
> 	__u32 bytes_len;
> 	__u8 bytes[MAX_BYTES];
> };
> 
> struct {
> 	__uint(type, BPF_MAP_TYPE_ARRAY);
> 	__uint(max_entries, 1);
> 	__type(key, __u32);
> 	__type(value, struct xxx_t);
> 	__uint(pinning, LIBBPF_PIN_BY_NAME);
> } my_map SEC(".maps");
> 
> char _license[] SEC("license") = "GPL";
> 
> SEC("egress")
> int egress_handler(struct __sk_buff *skb)
> {
> 	void *data_end = (void *)(long)skb->data_end;
> 	void *data = (void *)(long)skb->data;
> 	struct ethhdr *eth = data;
> 	struct ipv6hdr *ip6;
> 	struct xxx_t *x;
> 	__u32 offset;
> 	__u32 idx = 0;
> 
> 	offset = sizeof(*eth) + sizeof(*ip6);
> 	if (data + offset > data_end)
> 		return TC_ACT_OK;
> 
> 	if (bpf_ntohs(eth->h_proto) != ETH_P_IPV6)
> 		return TC_ACT_OK;
> 
> 	x = bpf_map_lookup_elem(&my_map, &idx);
> 	if (!x)
> 		return TC_ACT_OK;
> 
> 	if (x->bytes_len == 0 || x->bytes_len > MAX_BYTES)
> 		return TC_ACT_OK;
> 
> 	if (bpf_skb_adjust_room(skb, x->bytes_len, BPF_ADJ_ROOM_NET, 0))
> 		return TC_ACT_OK;
> 
> 	if (bpf_skb_store_bytes(skb, offset, x->bytes, 8/*x->bytes_len*/, 

You will see lots of folks & that value with something to
ensure compiler/verifier get a solid upper/lower bounds.
This is slightly kernel dependent the newer kernels are
better at tracking bounds.

This should do what you want more or less,

  x->bytes_len &= 0x7ff

