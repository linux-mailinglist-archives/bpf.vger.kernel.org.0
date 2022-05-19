Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9134252D76E
	for <lists+bpf@lfdr.de>; Thu, 19 May 2022 17:25:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240906AbiESPZR (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 19 May 2022 11:25:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240874AbiESPZP (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 19 May 2022 11:25:15 -0400
Received: from mail-ua1-x931.google.com (mail-ua1-x931.google.com [IPv6:2607:f8b0:4864:20::931])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03581EC328
        for <bpf@vger.kernel.org>; Thu, 19 May 2022 08:25:13 -0700 (PDT)
Received: by mail-ua1-x931.google.com with SMTP id m18so2110058uao.9
        for <bpf@vger.kernel.org>; Thu, 19 May 2022 08:25:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to;
        bh=TmWHiYDgikD+y21KQHJfo1bogRQx/GcSZlpZz3o2tKI=;
        b=N7qa5Vi43Xaemg3sFGQCH1NkNts5R/ivhc+jm9Qm+TfierH8UN7P5t3d9w0lU9VJBW
         so0F3026T9wowBmEq7aiNNU3ic4rAFfd+OVuYTzGKUU+YmzJ/CGf8iCAGLc4lACbmHoj
         iMCqpnT70cLMvL9/GrgWNtmSiKuyEmMFjrMHR6lwNiKcoMIa4ENIJk6FoXtr9gxpvCR0
         CA+I1Q/SBjfcca2IWkqe1ch1fZpjh+/xcPP0arJTF+SvVik1g8+9M8zPhrXtTw7pXaW1
         wSr/nCSiXmlfIfDnEc3dyX6iBVjOmluFF1tBv6th1B2620nqTRhnbm5ERRufhLMdz4Ow
         mjMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=TmWHiYDgikD+y21KQHJfo1bogRQx/GcSZlpZz3o2tKI=;
        b=BC850BqVRHB+6vxg3v4nqUfvF71Y8Wgxdg/+od0ak1LXqu+2Sc7p/TYOHrigEdojg8
         SSGLGjvZVIzL81SYWQtGRkqEa6yfPuDS0f0P8+l6+yBiK/okz8m7SvHSrowP45yq9a/8
         8sDqkcQd+kano/ZwE03w6OZuJ9bCnC3igSwkI7bvYZW/bnI53uz/wC6xGKtx/bohQ8sz
         Zz+iuIrLKr+kBBkaJfGgU3gh7DkBX+ziUgb3pfwsCA7f1oHv67frwWsvwaMgFccM2tuc
         hULASW/SVPSCsBvLVaD8hfvrHq+8gYYiBmX/Pm7fZyI9Y6ikM45FxnU+Diu3Xy2sTirw
         TWVw==
X-Gm-Message-State: AOAM531+0JFJ+d3cQvCR2admlaMBwLZVTRp2jgBWushA4/DRCQMtVMFo
        MyHIENmuVtBuxus4YZUJeMG1bxt8vLtunaTuH8nyVoRzv/2xHw==
X-Google-Smtp-Source: ABdhPJz/4V9a4JFymoyjPS9JFahH5af1dY+LvmuUCCC2bF24uaIO/lcSpnWtFrPDGYVvC+LBNc6UCGT/Z2IKGWoDL8o=
X-Received: by 2002:ab0:15ed:0:b0:365:f250:7384 with SMTP id
 j42-20020ab015ed000000b00365f2507384mr2201639uae.44.1652973911451; Thu, 19
 May 2022 08:25:11 -0700 (PDT)
MIME-Version: 1.0
From:   Vincent Li <vincent.mc.li@gmail.com>
Date:   Thu, 19 May 2022 08:25:00 -0700
Message-ID: <CAK3+h2xA+K-yby7m+3Hp1G6qinafZPW1OB=Uk5-AKxUfztBtEA@mail.gmail.com>
Subject: libbpf: failed to load program 'vxlan_get_tunnel_src'
To:     bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi,

Here is my step to run bpf selftest on Ubuntu 20.04.2 LTS

git clone https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git
cd bpf-next; cp /boot/config-5.10.0-051000-generic .config; yes "" |
make oldconfig; make bzImage; make modules; cd
tools/testing/selftests/bpf/; make

then below, am I missing something in kernel config to cause "libbpf:
failed to load program 'vxlan_get_tunnel_src'"

./test_progs -a tunnel

Failed to load bpf_testmod.ko into the kernel: -8

WARNING! Selftests relying on bpf_testmod.ko will be skipped.

serial_test_tunnel:PASS:pthread_create 0 nsec

config_device:PASS:ip netns add at_ns0 0 nsec

config_device:PASS:ip link add veth0 type veth peer name veth1 0 nsec

config_device:PASS:ip link set veth0 netns at_ns0 0 nsec

config_device:PASS:ip addr add 172.16.1.200/24 dev veth1 0 nsec

config_device:PASS:ip addr add 172.16.1.20/24 dev veth1 0 nsec

config_device:PASS:ip link set dev veth1 up mtu 1500 0 nsec

config_device:PASS:ip netns exec at_ns0 ip addr add 172.16.1.100/24
dev veth0 0 nsec

config_device:PASS:ip netns exec at_ns0 ip link set dev veth0 up mtu 1500 0 nsec

add_vxlan_tunnel:PASS:ip netns exec at_ns0 ip link add dev vxlan00
type vxlan external gbp dstport 4789 0 nsec

add_vxlan_tunnel:PASS:ip netns exec at_ns0 ip link set dev vxlan00
address 52:54:00:d9:01:00 up 0 nsec

add_vxlan_tunnel:PASS:ip netns exec at_ns0 ip addr add dev vxlan00
10.1.1.100/24 0 nsec

add_vxlan_tunnel:PASS:ip netns exec at_ns0 ip neigh add 10.1.1.200
lladdr 52:54:00:d9:02:00 dev vxlan00 0 nsec

add_vxlan_tunnel:PASS:ip link add dev vxlan11 type vxlan external gbp
dstport 4789 0 nsec

add_vxlan_tunnel:PASS:ip link set dev vxlan11 address
52:54:00:d9:02:00 up 0 nsec

add_vxlan_tunnel:PASS:ip addr add dev vxlan11 10.1.1.200/24 0 nsec

add_vxlan_tunnel:PASS:ip neigh add 10.1.1.100 lladdr 52:54:00:d9:01:00
dev vxlan11 0 nsec

test_vxlan_tunnel:PASS:add vxlan tunnel 0 nsec

libbpf: prog 'vxlan_get_tunnel_src': BPF program load failed: Invalid argument

libbpf: prog 'vxlan_get_tunnel_src': -- BEGIN PROG LOAD LOG --

; int vxlan_get_tunnel_src(struct __sk_buff *skb)

0: (bf) r7 = r1

1: (b4) w1 = 0

; __u32 index = 0;

2: (63) *(u32 *)(r10 -60) = r1

last_idx 2 first_idx 0

regs=2 stack=0 before 1: (b4) w1 = 0

3: (bf) r2 = r10

;

4: (07) r2 += -60

; local_ip = bpf_map_lookup_elem(&local_ip_map, &index);

5: (18) r1 = 0xffff8ec4dfed6400

7: (85) call bpf_map_lookup_elem#1

8: (bf) r6 = r0

; if (!local_ip) {

9: (55) if r6 != 0x0 goto pc+5


from 9 to 15: R0_w=map_value(id=0,off=0,ks=4,vs=4,imm=0)
R6_w=map_value(id=0,off=0,ks=4,vs=4,imm=0) R7_w=ctx(id=0,off=0,imm=0)
R10=fp0 fp-64=mmmm????

; log_err(ret);

15: (bf) r2 = r10

; ret = bpf_skb_get_tunnel_key(skb, &key, sizeof(key), 0);

16: (07) r2 += -48

17: (bf) r1 = r7

18: (b4) w3 = 44

19: (b7) r4 = 0

20: (85) call bpf_skb_get_tunnel_key#20

last_idx 20 first_idx 0

regs=8 stack=0 before 19: (b7) r4 = 0

regs=8 stack=0 before 18: (b4) w3 = 44

; if (ret < 0) {

21: (66) if w0 s> 0xffffffff goto pc+6


from 21 to 28: R0=inv(id=0,smax_value=9223372034707292159,umax_value=18446744071562067967,var_off=(0x0;
0xffffffff7fffffff),s32_min_value=0,u32_max_value=2147483647)
R6=map_value(id=0,off=0,ks=4,vs=4,imm=0) R7=ctx(id=0,off=0,imm=0)
R10=fp0 fp-8=????mmmm fp-16=mmmmmmmm fp-24=mmmmmmmm fp-32=mmmmmmmm
fp-40=mmmmmmmm fp-48=mmmmmmmm fp-64=mmmm????

; log_err(ret);

28: (bf) r2 = r10

; ret = bpf_skb_get_tunnel_opt(skb, &md, sizeof(md));

29: (07) r2 += -56

30: (bf) r1 = r7

31: (b4) w3 = 4

32: (85) call bpf_skb_get_tunnel_opt#29

last_idx 32 first_idx 21

regs=8 stack=0 before 31: (b4) w3 = 4

33: (bf) r7 = r0

; if (ret < 0) {

34: (66) if w7 s> 0xffffffff goto pc+5


from 34 to 40: R0_w=inv(id=2,smax_value=9223372034707292159,umax_value=18446744071562067967,var_off=(0x0;
0xffffffff7fffffff),s32_min_value=0,u32_max_value=2147483647)
R6=map_value(id=0,off=0,ks=4,vs=4,imm=0)
R7_w=inv(id=2,smax_value=9223372034707292159,umax_value=18446744071562067967,var_off=(0x0;
0xffffffff7fffffff),s32_min_value=0,u32_max_value=2147483647) R10=fp0
fp-8=????mmmm fp-16=mmmmmmmm fp-24=mmmmmmmm fp-32=mmmmmmmm
fp-40=mmmmmmmm fp-48=mmmmmmmm fp-56=????mmmm fp-64=mmmm????

; log_err(ret);

40: (61) r1 = *(u32 *)(r10 -56)

; if (key.local_ipv4 != *local_ip || md.gbp != 0x800FF) {

41: (61) r3 = *(u32 *)(r6 +0)

 R0_w=inv(id=2,smax_value=9223372034707292159,umax_value=18446744071562067967,var_off=(0x0;
0xffffffff7fffffff),s32_min_value=0,u32_max_value=2147483647)
R1_w=inv(id=0,umax_value=4294967295,var_off=(0x0; 0xffffffff))
R6=map_value(id=0,off=0,ks=4,vs=4,imm=0)
R7_w=inv(id=2,smax_value=9223372034707292159,umax_value=18446744071562067967,var_off=(0x0;
0xffffffff7fffffff),s32_min_value=0,u32_max_value=2147483647) R10=fp0
fp-8=????mmmm fp-16=mmmmmmmm fp-24=mmmmmmmm fp-32=mmmmmmmm
fp-40=mmmmmmmm fp-48=mmmmmmmm fp-56=????mmmm fp-64=mmmm????

; if (key.local_ipv4 != *local_ip || md.gbp != 0x800FF) {

42: (61) r2 = *(u32 *)(r10 -20)

; if (key.local_ipv4 != *local_ip || md.gbp != 0x800FF) {

43: (5e) if w2 != w3 goto pc+2

 R0_w=inv(id=2,smax_value=9223372034707292159,umax_value=18446744071562067967,var_off=(0x0;
0xffffffff7fffffff),s32_min_value=0,u32_max_value=2147483647)
R1_w=inv(id=0,umax_value=4294967295,var_off=(0x0; 0xffffffff))
R2_w=inv(id=0,umax_value=4294967295,var_off=(0x0; 0xffffffff))
R3_w=inv(id=0,umax_value=4294967295,var_off=(0x0; 0xffffffff))
R6=map_value(id=0,off=0,ks=4,vs=4,imm=0)
R7_w=inv(id=2,smax_value=9223372034707292159,umax_value=18446744071562067967,var_off=(0x0;
0xffffffff7fffffff),s32_min_value=0,u32_max_value=2147483647) R10=fp0
fp-8=????mmmm fp-16=mmmmmmmm fp-24=mmmmmmmm fp-32=mmmmmmmm
fp-40=mmmmmmmm fp-48=mmmmmmmm fp-56=????mmmm fp-64=mmmm????

44: (b4) w0 = 0

45: (16) if w1 == 0x800ff goto pc+25

 R0=inv0 R1=inv(id=0,umax_value=4294967295,var_off=(0x0; 0xffffffff))
R2=inv(id=0,umax_value=4294967295,var_off=(0x0; 0xffffffff))
R3=inv(id=0,umax_value=4294967295,var_off=(0x0; 0xffffffff))
R6=map_value(id=0,off=0,ks=4,vs=4,imm=0)
R7=inv(id=2,smax_value=9223372034707292159,umax_value=18446744071562067967,var_off=(0x0;
0xffffffff7fffffff),s32_min_value=0,u32_max_value=2147483647) R10=fp0
fp-8=????mmmm fp-16=mmmmmmmm fp-24=mmmmmmmm fp-32=mmmmmmmm
fp-40=mmmmmmmm fp-48=mmmmmmmm fp-56=????mmmm fp-64=mmmm????

; bpf_printk("vxlan key %d local ip 0x%x remote ip 0x%x gbp 0x%x\n",

46: (7b) *(u64 *)(r10 -88) = r2

47: (7b) *(u64 *)(r10 -72) = r1

48: (61) r1 = *(u32 *)(r10 -48)

49: (7b) *(u64 *)(r10 -96) = r1

50: (61) r1 = *(u32 *)(r10 -44)

51: (7b) *(u64 *)(r10 -80) = r1

52: (bf) r3 = r10

53: (07) r3 += -96

54: (18) r1 = 0xffffabaec02c82af

56: (b4) w2 = 52

57: (b4) w4 = 32

58: (85) call unknown#177

invalid func unknown#177

processed 64 insns (limit 1000000) max_states_per_insn 1 total_states
5 peak_states 5 mark_read 2

-- END PROG LOAD LOG --

libbpf: failed to load program 'vxlan_get_tunnel_src'

libbpf: failed to load object 'test_tunnel_kern'

libbpf: failed to load BPF skeleton 'test_tunnel_kern': -22

test_vxlan_tunnel:FAIL:test_tunnel_kern__open_and_load unexpected error: -22

#198/1     tunnel/vxlan_tunnel:FAIL

add_ip6vxlan_tunnel:PASS:ip netns exec at_ns0 ip -6 addr add ::11/96
dev veth0 0 nsec

add_ip6vxlan_tunnel:PASS:ip netns exec at_ns0 ip link set dev veth0 up 0 nsec

add_ip6vxlan_tunnel:PASS:ip -6 addr add ::22/96 dev veth1 0 nsec

add_ip6vxlan_tunnel:PASS:ip -6 addr add ::bb/96 dev veth1 0 nsec

add_ip6vxlan_tunnel:PASS:ip link set dev veth1 up 0 nsec

add_ip6vxlan_tunnel:PASS:ip netns exec at_ns0 ip link add dev
ip6vxlan00 type vxlan external dstport 4789 0 nsec

add_ip6vxlan_tunnel:PASS:ip netns exec at_ns0 ip addr add dev
ip6vxlan00 10.1.1.100/24 0 nsec

add_ip6vxlan_tunnel:PASS:ip netns exec at_ns0 ip link set dev
ip6vxlan00 address 52:54:00:d9:01:00 up 0 nsec

add_ip6vxlan_tunnel:PASS:ip link add dev ip6vxlan11 type vxlan
external dstport 4789 0 nsec

add_ip6vxlan_tunnel:PASS:ip addr add dev ip6vxlan11 10.1.1.200/24 0 nsec

add_ip6vxlan_tunnel:PASS:ip link set dev ip6vxlan11 address
52:54:00:d9:02:00 up 0 nsec

test_ip6vxlan_tunnel:PASS:add_ip6vxlan_tunnel 0 nsec

libbpf: prog 'vxlan_get_tunnel_src': BPF program load failed: Invalid argument

libbpf: prog 'vxlan_get_tunnel_src': -- BEGIN PROG LOAD LOG --

; int vxlan_get_tunnel_src(struct __sk_buff *skb)

0: (bf) r7 = r1

1: (b4) w1 = 0

; __u32 index = 0;

2: (63) *(u32 *)(r10 -60) = r1

last_idx 2 first_idx 0

regs=2 stack=0 before 1: (b4) w1 = 0

3: (bf) r2 = r10

;

4: (07) r2 += -60

; local_ip = bpf_map_lookup_elem(&local_ip_map, &index);

5: (18) r1 = 0xffff8ec4de898600

7: (85) call bpf_map_lookup_elem#1

8: (bf) r6 = r0

; if (!local_ip) {

9: (55) if r6 != 0x0 goto pc+5


from 9 to 15: R0_w=map_value(id=0,off=0,ks=4,vs=4,imm=0)
R6_w=map_value(id=0,off=0,ks=4,vs=4,imm=0) R7_w=ctx(id=0,off=0,imm=0)
R10=fp0 fp-64=mmmm????

; log_err(ret);

15: (bf) r2 = r10

; ret = bpf_skb_get_tunnel_key(skb, &key, sizeof(key), 0);

16: (07) r2 += -48

17: (bf) r1 = r7

18: (b4) w3 = 44

19: (b7) r4 = 0

20: (85) call bpf_skb_get_tunnel_key#20

last_idx 20 first_idx 0

regs=8 stack=0 before 19: (b7) r4 = 0

regs=8 stack=0 before 18: (b4) w3 = 44

; if (ret < 0) {

21: (66) if w0 s> 0xffffffff goto pc+6


from 21 to 28: R0=inv(id=0,smax_value=9223372034707292159,umax_value=18446744071562067967,var_off=(0x0;
0xffffffff7fffffff),s32_min_value=0,u32_max_value=2147483647)
R6=map_value(id=0,off=0,ks=4,vs=4,imm=0) R7=ctx(id=0,off=0,imm=0)
R10=fp0 fp-8=????mmmm fp-16=mmmmmmmm fp-24=mmmmmmmm fp-32=mmmmmmmm
fp-40=mmmmmmmm fp-48=mmmmmmmm fp-64=mmmm????

; log_err(ret);

28: (bf) r2 = r10

; ret = bpf_skb_get_tunnel_opt(skb, &md, sizeof(md));

29: (07) r2 += -56

30: (bf) r1 = r7

31: (b4) w3 = 4

32: (85) call bpf_skb_get_tunnel_opt#29

last_idx 32 first_idx 21

regs=8 stack=0 before 31: (b4) w3 = 4

33: (bf) r7 = r0

; if (ret < 0) {

34: (66) if w7 s> 0xffffffff goto pc+5


from 34 to 40: R0_w=inv(id=2,smax_value=9223372034707292159,umax_value=18446744071562067967,var_off=(0x0;
0xffffffff7fffffff),s32_min_value=0,u32_max_value=2147483647)
R6=map_value(id=0,off=0,ks=4,vs=4,imm=0)
R7_w=inv(id=2,smax_value=9223372034707292159,umax_value=18446744071562067967,var_off=(0x0;
0xffffffff7fffffff),s32_min_value=0,u32_max_value=2147483647) R10=fp0
fp-8=????mmmm fp-16=mmmmmmmm fp-24=mmmmmmmm fp-32=mmmmmmmm
fp-40=mmmmmmmm fp-48=mmmmmmmm fp-56=????mmmm fp-64=mmmm????

; log_err(ret);

40: (61) r1 = *(u32 *)(r10 -56)

; if (key.local_ipv4 != *local_ip || md.gbp != 0x800FF) {

41: (61) r3 = *(u32 *)(r6 +0)

 R0_w=inv(id=2,smax_value=9223372034707292159,umax_value=18446744071562067967,var_off=(0x0;
0xffffffff7fffffff),s32_min_value=0,u32_max_value=2147483647)
R1_w=inv(id=0,umax_value=4294967295,var_off=(0x0; 0xffffffff))
R6=map_value(id=0,off=0,ks=4,vs=4,imm=0)
R7_w=inv(id=2,smax_value=9223372034707292159,umax_value=18446744071562067967,var_off=(0x0;
0xffffffff7fffffff),s32_min_value=0,u32_max_value=2147483647) R10=fp0
fp-8=????mmmm fp-16=mmmmmmmm fp-24=mmmmmmmm fp-32=mmmmmmmm
fp-40=mmmmmmmm fp-48=mmmmmmmm fp-56=????mmmm fp-64=mmmm????

; if (key.local_ipv4 != *local_ip || md.gbp != 0x800FF) {

42: (61) r2 = *(u32 *)(r10 -20)

; if (key.local_ipv4 != *local_ip || md.gbp != 0x800FF) {

43: (5e) if w2 != w3 goto pc+2

 R0_w=inv(id=2,smax_value=9223372034707292159,umax_value=18446744071562067967,var_off=(0x0;
0xffffffff7fffffff),s32_min_value=0,u32_max_value=2147483647)
R1_w=inv(id=0,umax_value=4294967295,var_off=(0x0; 0xffffffff))
R2_w=inv(id=0,umax_value=4294967295,var_off=(0x0; 0xffffffff))
R3_w=inv(id=0,umax_value=4294967295,var_off=(0x0; 0xffffffff))
R6=map_value(id=0,off=0,ks=4,vs=4,imm=0)
R7_w=inv(id=2,smax_value=9223372034707292159,umax_value=18446744071562067967,var_off=(0x0;
0xffffffff7fffffff),s32_min_value=0,u32_max_value=2147483647) R10=fp0
fp-8=????mmmm fp-16=mmmmmmmm fp-24=mmmmmmmm fp-32=mmmmmmmm
fp-40=mmmmmmmm fp-48=mmmmmmmm fp-56=????mmmm fp-64=mmmm????

44: (b4) w0 = 0

45: (16) if w1 == 0x800ff goto pc+25

 R0=inv0 R1=inv(id=0,umax_value=4294967295,var_off=(0x0; 0xffffffff))
R2=inv(id=0,umax_value=4294967295,var_off=(0x0; 0xffffffff))
R3=inv(id=0,umax_value=4294967295,var_off=(0x0; 0xffffffff))
R6=map_value(id=0,off=0,ks=4,vs=4,imm=0)
R7=inv(id=2,smax_value=9223372034707292159,umax_value=18446744071562067967,var_off=(0x0;
0xffffffff7fffffff),s32_min_value=0,u32_max_value=2147483647) R10=fp0
fp-8=????mmmm fp-16=mmmmmmmm fp-24=mmmmmmmm fp-32=mmmmmmmm
fp-40=mmmmmmmm fp-48=mmmmmmmm fp-56=????mmmm fp-64=mmmm????

; bpf_printk("vxlan key %d local ip 0x%x remote ip 0x%x gbp 0x%x\n",

46: (7b) *(u64 *)(r10 -88) = r2

47: (7b) *(u64 *)(r10 -72) = r1

48: (61) r1 = *(u32 *)(r10 -48)

49: (7b) *(u64 *)(r10 -96) = r1

50: (61) r1 = *(u32 *)(r10 -44)

51: (7b) *(u64 *)(r10 -80) = r1

52: (bf) r3 = r10

53: (07) r3 += -96

54: (18) r1 = 0xffffabaec02c82af

56: (b4) w2 = 52

57: (b4) w4 = 32

58: (85) call unknown#177

invalid func unknown#177

processed 64 insns (limit 1000000) max_states_per_insn 1 total_states
5 peak_states 5 mark_read 2

-- END PROG LOAD LOG --

libbpf: failed to load program 'vxlan_get_tunnel_src'

libbpf: failed to load object 'test_tunnel_kern'

libbpf: failed to load BPF skeleton 'test_tunnel_kern': -22

test_ip6vxlan_tunnel:FAIL:test_tunnel_kern__open_and_load unexpected error: -22

serial_test_tunnel:PASS:pthread_join 0 nsec

#198/2     tunnel/ip6vxlan_tunnel:FAIL

#198       tunnel:FAIL


All error logs:

serial_test_tunnel:PASS:pthread_create 0 nsec

config_device:PASS:ip netns add at_ns0 0 nsec

config_device:PASS:ip link add veth0 type veth peer name veth1 0 nsec

config_device:PASS:ip link set veth0 netns at_ns0 0 nsec

config_device:PASS:ip addr add 172.16.1.200/24 dev veth1 0 nsec

config_device:PASS:ip addr add 172.16.1.20/24 dev veth1 0 nsec

config_device:PASS:ip link set dev veth1 up mtu 1500 0 nsec

config_device:PASS:ip netns exec at_ns0 ip addr add 172.16.1.100/24
dev veth0 0 nsec

config_device:PASS:ip netns exec at_ns0 ip link set dev veth0 up mtu 1500 0 nsec

add_vxlan_tunnel:PASS:ip netns exec at_ns0 ip link add dev vxlan00
type vxlan external gbp dstport 4789 0 nsec

add_vxlan_tunnel:PASS:ip netns exec at_ns0 ip link set dev vxlan00
address 52:54:00:d9:01:00 up 0 nsec

add_vxlan_tunnel:PASS:ip netns exec at_ns0 ip addr add dev vxlan00
10.1.1.100/24 0 nsec

add_vxlan_tunnel:PASS:ip netns exec at_ns0 ip neigh add 10.1.1.200
lladdr 52:54:00:d9:02:00 dev vxlan00 0 nsec

add_vxlan_tunnel:PASS:ip link add dev vxlan11 type vxlan external gbp
dstport 4789 0 nsec

add_vxlan_tunnel:PASS:ip link set dev vxlan11 address
52:54:00:d9:02:00 up 0 nsec

add_vxlan_tunnel:PASS:ip addr add dev vxlan11 10.1.1.200/24 0 nsec

add_vxlan_tunnel:PASS:ip neigh add 10.1.1.100 lladdr 52:54:00:d9:01:00
dev vxlan11 0 nsec

test_vxlan_tunnel:PASS:add vxlan tunnel 0 nsec

libbpf: prog 'vxlan_get_tunnel_src': BPF program load failed: Invalid argument

libbpf: prog 'vxlan_get_tunnel_src': -- BEGIN PROG LOAD LOG --

; int vxlan_get_tunnel_src(struct __sk_buff *skb)

0: (bf) r7 = r1

1: (b4) w1 = 0

; __u32 index = 0;

2: (63) *(u32 *)(r10 -60) = r1

last_idx 2 first_idx 0

regs=2 stack=0 before 1: (b4) w1 = 0

3: (bf) r2 = r10

;

4: (07) r2 += -60

; local_ip = bpf_map_lookup_elem(&local_ip_map, &index);

5: (18) r1 = 0xffff8ec4dfed6400

7: (85) call bpf_map_lookup_elem#1

8: (bf) r6 = r0

; if (!local_ip) {

9: (55) if r6 != 0x0 goto pc+5


from 9 to 15: R0_w=map_value(id=0,off=0,ks=4,vs=4,imm=0)
R6_w=map_value(id=0,off=0,ks=4,vs=4,imm=0) R7_w=ctx(id=0,off=0,imm=0)
R10=fp0 fp-64=mmmm????

; log_err(ret);

15: (bf) r2 = r10

; ret = bpf_skb_get_tunnel_key(skb, &key, sizeof(key), 0);

16: (07) r2 += -48

17: (bf) r1 = r7

18: (b4) w3 = 44

19: (b7) r4 = 0

20: (85) call bpf_skb_get_tunnel_key#20

last_idx 20 first_idx 0

regs=8 stack=0 before 19: (b7) r4 = 0

regs=8 stack=0 before 18: (b4) w3 = 44

; if (ret < 0) {

21: (66) if w0 s> 0xffffffff goto pc+6


from 21 to 28: R0=inv(id=0,smax_value=9223372034707292159,umax_value=18446744071562067967,var_off=(0x0;
0xffffffff7fffffff),s32_min_value=0,u32_max_value=2147483647)
R6=map_value(id=0,off=0,ks=4,vs=4,imm=0) R7=ctx(id=0,off=0,imm=0)
R10=fp0 fp-8=????mmmm fp-16=mmmmmmmm fp-24=mmmmmmmm fp-32=mmmmmmmm
fp-40=mmmmmmmm fp-48=mmmmmmmm fp-64=mmmm????

; log_err(ret);

28: (bf) r2 = r10

; ret = bpf_skb_get_tunnel_opt(skb, &md, sizeof(md));

29: (07) r2 += -56

30: (bf) r1 = r7

31: (b4) w3 = 4

32: (85) call bpf_skb_get_tunnel_opt#29

last_idx 32 first_idx 21

regs=8 stack=0 before 31: (b4) w3 = 4

33: (bf) r7 = r0

; if (ret < 0) {

34: (66) if w7 s> 0xffffffff goto pc+5


from 34 to 40: R0_w=inv(id=2,smax_value=9223372034707292159,umax_value=18446744071562067967,var_off=(0x0;
0xffffffff7fffffff),s32_min_value=0,u32_max_value=2147483647)
R6=map_value(id=0,off=0,ks=4,vs=4,imm=0)
R7_w=inv(id=2,smax_value=9223372034707292159,umax_value=18446744071562067967,var_off=(0x0;
0xffffffff7fffffff),s32_min_value=0,u32_max_value=2147483647) R10=fp0
fp-8=????mmmm fp-16=mmmmmmmm fp-24=mmmmmmmm fp-32=mmmmmmmm
fp-40=mmmmmmmm fp-48=mmmmmmmm fp-56=????mmmm fp-64=mmmm????

; log_err(ret);

40: (61) r1 = *(u32 *)(r10 -56)

; if (key.local_ipv4 != *local_ip || md.gbp != 0x800FF) {

41: (61) r3 = *(u32 *)(r6 +0)

 R0_w=inv(id=2,smax_value=9223372034707292159,umax_value=18446744071562067967,var_off=(0x0;
0xffffffff7fffffff),s32_min_value=0,u32_max_value=2147483647)
R1_w=inv(id=0,umax_value=4294967295,var_off=(0x0; 0xffffffff))
R6=map_value(id=0,off=0,ks=4,vs=4,imm=0)
R7_w=inv(id=2,smax_value=9223372034707292159,umax_value=18446744071562067967,var_off=(0x0;
0xffffffff7fffffff),s32_min_value=0,u32_max_value=2147483647) R10=fp0
fp-8=????mmmm fp-16=mmmmmmmm fp-24=mmmmmmmm fp-32=mmmmmmmm
fp-40=mmmmmmmm fp-48=mmmmmmmm fp-56=????mmmm fp-64=mmmm????

; if (key.local_ipv4 != *local_ip || md.gbp != 0x800FF) {

42: (61) r2 = *(u32 *)(r10 -20)

; if (key.local_ipv4 != *local_ip || md.gbp != 0x800FF) {

43: (5e) if w2 != w3 goto pc+2

 R0_w=inv(id=2,smax_value=9223372034707292159,umax_value=18446744071562067967,var_off=(0x0;
0xffffffff7fffffff),s32_min_value=0,u32_max_value=2147483647)
R1_w=inv(id=0,umax_value=4294967295,var_off=(0x0; 0xffffffff))
R2_w=inv(id=0,umax_value=4294967295,var_off=(0x0; 0xffffffff))
R3_w=inv(id=0,umax_value=4294967295,var_off=(0x0; 0xffffffff))
R6=map_value(id=0,off=0,ks=4,vs=4,imm=0)
R7_w=inv(id=2,smax_value=9223372034707292159,umax_value=18446744071562067967,var_off=(0x0;
0xffffffff7fffffff),s32_min_value=0,u32_max_value=2147483647) R10=fp0
fp-8=????mmmm fp-16=mmmmmmmm fp-24=mmmmmmmm fp-32=mmmmmmmm
fp-40=mmmmmmmm fp-48=mmmmmmmm fp-56=????mmmm fp-64=mmmm????

44: (b4) w0 = 0

45: (16) if w1 == 0x800ff goto pc+25

 R0=inv0 R1=inv(id=0,umax_value=4294967295,var_off=(0x0; 0xffffffff))
R2=inv(id=0,umax_value=4294967295,var_off=(0x0; 0xffffffff))
R3=inv(id=0,umax_value=4294967295,var_off=(0x0; 0xffffffff))
R6=map_value(id=0,off=0,ks=4,vs=4,imm=0)
R7=inv(id=2,smax_value=9223372034707292159,umax_value=18446744071562067967,var_off=(0x0;
0xffffffff7fffffff),s32_min_value=0,u32_max_value=2147483647) R10=fp0
fp-8=????mmmm fp-16=mmmmmmmm fp-24=mmmmmmmm fp-32=mmmmmmmm
fp-40=mmmmmmmm fp-48=mmmmmmmm fp-56=????mmmm fp-64=mmmm????

; bpf_printk("vxlan key %d local ip 0x%x remote ip 0x%x gbp 0x%x\n",

46: (7b) *(u64 *)(r10 -88) = r2

47: (7b) *(u64 *)(r10 -72) = r1

48: (61) r1 = *(u32 *)(r10 -48)

49: (7b) *(u64 *)(r10 -96) = r1

50: (61) r1 = *(u32 *)(r10 -44)

51: (7b) *(u64 *)(r10 -80) = r1

52: (bf) r3 = r10

53: (07) r3 += -96

54: (18) r1 = 0xffffabaec02c82af

56: (b4) w2 = 52

57: (b4) w4 = 32

58: (85) call unknown#177

invalid func unknown#177

processed 64 insns (limit 1000000) max_states_per_insn 1 total_states
5 peak_states 5 mark_read 2

-- END PROG LOAD LOG --

libbpf: failed to load program 'vxlan_get_tunnel_src'

libbpf: failed to load object 'test_tunnel_kern'

libbpf: failed to load BPF skeleton 'test_tunnel_kern': -22

test_vxlan_tunnel:FAIL:test_tunnel_kern__open_and_load unexpected error: -22

#198/1     tunnel/vxlan_tunnel:FAIL

add_ip6vxlan_tunnel:PASS:ip netns exec at_ns0 ip -6 addr add ::11/96
dev veth0 0 nsec

add_ip6vxlan_tunnel:PASS:ip netns exec at_ns0 ip link set dev veth0 up 0 nsec

add_ip6vxlan_tunnel:PASS:ip -6 addr add ::22/96 dev veth1 0 nsec

add_ip6vxlan_tunnel:PASS:ip -6 addr add ::bb/96 dev veth1 0 nsec

add_ip6vxlan_tunnel:PASS:ip link set dev veth1 up 0 nsec

add_ip6vxlan_tunnel:PASS:ip netns exec at_ns0 ip link add dev
ip6vxlan00 type vxlan external dstport 4789 0 nsec

add_ip6vxlan_tunnel:PASS:ip netns exec at_ns0 ip addr add dev
ip6vxlan00 10.1.1.100/24 0 nsec

add_ip6vxlan_tunnel:PASS:ip netns exec at_ns0 ip link set dev
ip6vxlan00 address 52:54:00:d9:01:00 up 0 nsec

add_ip6vxlan_tunnel:PASS:ip link add dev ip6vxlan11 type vxlan
external dstport 4789 0 nsec

add_ip6vxlan_tunnel:PASS:ip addr add dev ip6vxlan11 10.1.1.200/24 0 nsec

add_ip6vxlan_tunnel:PASS:ip link set dev ip6vxlan11 address
52:54:00:d9:02:00 up 0 nsec

test_ip6vxlan_tunnel:PASS:add_ip6vxlan_tunnel 0 nsec

libbpf: prog 'vxlan_get_tunnel_src': BPF program load failed: Invalid argument

libbpf: prog 'vxlan_get_tunnel_src': -- BEGIN PROG LOAD LOG --

; int vxlan_get_tunnel_src(struct __sk_buff *skb)

0: (bf) r7 = r1

1: (b4) w1 = 0

; __u32 index = 0;

2: (63) *(u32 *)(r10 -60) = r1

last_idx 2 first_idx 0

regs=2 stack=0 before 1: (b4) w1 = 0

3: (bf) r2 = r10

;

4: (07) r2 += -60

; local_ip = bpf_map_lookup_elem(&local_ip_map, &index);

5: (18) r1 = 0xffff8ec4de898600

7: (85) call bpf_map_lookup_elem#1

8: (bf) r6 = r0

; if (!local_ip) {

9: (55) if r6 != 0x0 goto pc+5


from 9 to 15: R0_w=map_value(id=0,off=0,ks=4,vs=4,imm=0)
R6_w=map_value(id=0,off=0,ks=4,vs=4,imm=0) R7_w=ctx(id=0,off=0,imm=0)
R10=fp0 fp-64=mmmm????

; log_err(ret);

15: (bf) r2 = r10

; ret = bpf_skb_get_tunnel_key(skb, &key, sizeof(key), 0);

16: (07) r2 += -48

17: (bf) r1 = r7

18: (b4) w3 = 44

19: (b7) r4 = 0

20: (85) call bpf_skb_get_tunnel_key#20

last_idx 20 first_idx 0

regs=8 stack=0 before 19: (b7) r4 = 0

regs=8 stack=0 before 18: (b4) w3 = 44

; if (ret < 0) {

21: (66) if w0 s> 0xffffffff goto pc+6


from 21 to 28: R0=inv(id=0,smax_value=9223372034707292159,umax_value=18446744071562067967,var_off=(0x0;
0xffffffff7fffffff),s32_min_value=0,u32_max_value=2147483647)
R6=map_value(id=0,off=0,ks=4,vs=4,imm=0) R7=ctx(id=0,off=0,imm=0)
R10=fp0 fp-8=????mmmm fp-16=mmmmmmmm fp-24=mmmmmmmm fp-32=mmmmmmmm
fp-40=mmmmmmmm fp-48=mmmmmmmm fp-64=mmmm????

; log_err(ret);

28: (bf) r2 = r10

; ret = bpf_skb_get_tunnel_opt(skb, &md, sizeof(md));

29: (07) r2 += -56

30: (bf) r1 = r7

31: (b4) w3 = 4

32: (85) call bpf_skb_get_tunnel_opt#29

last_idx 32 first_idx 21

regs=8 stack=0 before 31: (b4) w3 = 4

33: (bf) r7 = r0

; if (ret < 0) {

34: (66) if w7 s> 0xffffffff goto pc+5


from 34 to 40: R0_w=inv(id=2,smax_value=9223372034707292159,umax_value=18446744071562067967,var_off=(0x0;
0xffffffff7fffffff),s32_min_value=0,u32_max_value=2147483647)
R6=map_value(id=0,off=0,ks=4,vs=4,imm=0)
R7_w=inv(id=2,smax_value=9223372034707292159,umax_value=18446744071562067967,var_off=(0x0;
0xffffffff7fffffff),s32_min_value=0,u32_max_value=2147483647) R10=fp0
fp-8=????mmmm fp-16=mmmmmmmm fp-24=mmmmmmmm fp-32=mmmmmmmm
fp-40=mmmmmmmm fp-48=mmmmmmmm fp-56=????mmmm fp-64=mmmm????

; log_err(ret);

40: (61) r1 = *(u32 *)(r10 -56)

; if (key.local_ipv4 != *local_ip || md.gbp != 0x800FF) {

41: (61) r3 = *(u32 *)(r6 +0)

 R0_w=inv(id=2,smax_value=9223372034707292159,umax_value=18446744071562067967,var_off=(0x0;
0xffffffff7fffffff),s32_min_value=0,u32_max_value=2147483647)
R1_w=inv(id=0,umax_value=4294967295,var_off=(0x0; 0xffffffff))
R6=map_value(id=0,off=0,ks=4,vs=4,imm=0)
R7_w=inv(id=2,smax_value=9223372034707292159,umax_value=18446744071562067967,var_off=(0x0;
0xffffffff7fffffff),s32_min_value=0,u32_max_value=2147483647) R10=fp0
fp-8=????mmmm fp-16=mmmmmmmm fp-24=mmmmmmmm fp-32=mmmmmmmm
fp-40=mmmmmmmm fp-48=mmmmmmmm fp-56=????mmmm fp-64=mmmm????

; if (key.local_ipv4 != *local_ip || md.gbp != 0x800FF) {

42: (61) r2 = *(u32 *)(r10 -20)

; if (key.local_ipv4 != *local_ip || md.gbp != 0x800FF) {

43: (5e) if w2 != w3 goto pc+2

 R0_w=inv(id=2,smax_value=9223372034707292159,umax_value=18446744071562067967,var_off=(0x0;
0xffffffff7fffffff),s32_min_value=0,u32_max_value=2147483647)
R1_w=inv(id=0,umax_value=4294967295,var_off=(0x0; 0xffffffff))
R2_w=inv(id=0,umax_value=4294967295,var_off=(0x0; 0xffffffff))
R3_w=inv(id=0,umax_value=4294967295,var_off=(0x0; 0xffffffff))
R6=map_value(id=0,off=0,ks=4,vs=4,imm=0)
R7_w=inv(id=2,smax_value=9223372034707292159,umax_value=18446744071562067967,var_off=(0x0;
0xffffffff7fffffff),s32_min_value=0,u32_max_value=2147483647) R10=fp0
fp-8=????mmmm fp-16=mmmmmmmm fp-24=mmmmmmmm fp-32=mmmmmmmm
fp-40=mmmmmmmm fp-48=mmmmmmmm fp-56=????mmmm fp-64=mmmm????

44: (b4) w0 = 0

45: (16) if w1 == 0x800ff goto pc+25

 R0=inv0 R1=inv(id=0,umax_value=4294967295,var_off=(0x0; 0xffffffff))
R2=inv(id=0,umax_value=4294967295,var_off=(0x0; 0xffffffff))
R3=inv(id=0,umax_value=4294967295,var_off=(0x0; 0xffffffff))
R6=map_value(id=0,off=0,ks=4,vs=4,imm=0)
R7=inv(id=2,smax_value=9223372034707292159,umax_value=18446744071562067967,var_off=(0x0;
0xffffffff7fffffff),s32_min_value=0,u32_max_value=2147483647) R10=fp0
fp-8=????mmmm fp-16=mmmmmmmm fp-24=mmmmmmmm fp-32=mmmmmmmm
fp-40=mmmmmmmm fp-48=mmmmmmmm fp-56=????mmmm fp-64=mmmm????

; bpf_printk("vxlan key %d local ip 0x%x remote ip 0x%x gbp 0x%x\n",

46: (7b) *(u64 *)(r10 -88) = r2

47: (7b) *(u64 *)(r10 -72) = r1

48: (61) r1 = *(u32 *)(r10 -48)

49: (7b) *(u64 *)(r10 -96) = r1

50: (61) r1 = *(u32 *)(r10 -44)

51: (7b) *(u64 *)(r10 -80) = r1

52: (bf) r3 = r10

53: (07) r3 += -96

54: (18) r1 = 0xffffabaec02c82af

56: (b4) w2 = 52

57: (b4) w4 = 32

58: (85) call unknown#177

invalid func unknown#177

processed 64 insns (limit 1000000) max_states_per_insn 1 total_states
5 peak_states 5 mark_read 2

-- END PROG LOAD LOG --

libbpf: failed to load program 'vxlan_get_tunnel_src'

libbpf: failed to load object 'test_tunnel_kern'

libbpf: failed to load BPF skeleton 'test_tunnel_kern': -22

test_ip6vxlan_tunnel:FAIL:test_tunnel_kern__open_and_load unexpected error: -22

serial_test_tunnel:PASS:pthread_join 0 nsec

#198/2     tunnel/ip6vxlan_tunnel:FAIL

#198       tunnel:FAIL

Summary: 0/0 PASSED, 0 SKIPPED, 1 FAILED
