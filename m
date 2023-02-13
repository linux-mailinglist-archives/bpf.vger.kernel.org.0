Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AF83695045
	for <lists+bpf@lfdr.de>; Mon, 13 Feb 2023 20:05:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229576AbjBMTFA (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 13 Feb 2023 14:05:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231217AbjBMTE7 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 13 Feb 2023 14:04:59 -0500
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 642AF5B8D
        for <bpf@vger.kernel.org>; Mon, 13 Feb 2023 11:04:42 -0800 (PST)
Received: by mail-pl1-x62c.google.com with SMTP id w5so14498324plg.8
        for <bpf@vger.kernel.org>; Mon, 13 Feb 2023 11:04:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1676315081;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=rjjOYPRmhaM+wATLrynbUxHs/MiROBVLAdTjN4+mQaI=;
        b=Ll5hlG2MLDvK5iXigNRRniO5+eUS/wAKKOECr3Bqa+gH509smhffGWo6EsWWhbSvcf
         SnYYBOFx7lobO7byVnvggPO4QclpEBnby+pItP55L+4QC7dkpaxS+ChzzFv29Ej0nw9O
         JSTv/j3c8jmp93pWKOkhJis59qG56Ad6VXZihbyitRo402R/Ve80IrX0Fm9w4ojdaIau
         WMMvHQZr93+V9Rhw6e9wLrRL9+HG6/VNCLS+8VR6TGyA+GcfBZxuHa/qvkExTTR79RIf
         q1LO5I9kpqBKdwqHxXe+OdmXQKnASe0batZSQkbS9YFhgbIiWPRgl5RrPKaKeow4XEtI
         dXhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1676315081;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rjjOYPRmhaM+wATLrynbUxHs/MiROBVLAdTjN4+mQaI=;
        b=1LAAEck5KlAqP9Gqxg9cGyMc4A9N8BFNEn1AwN6bu0d3v8im41xES9vFa61cDc2fug
         onVVUnHwS4EvSkvJdsZHJRJxmHXr5e27rQeqpGFwT1sLqraP/ZghIJPdGNJIBXPau4al
         FsGinvgzgMUgls6IbLHFeb+WVU5Ij/DxE9Mk5Lm7G+qTUSRgLe1QBzFwyAslNN05Nbug
         UFMFclU0q6uc18I7FUTEIIIrZj2gROg6T7fPY3U6q2wVltKexc3CyHRFqpgYLv2G2o8B
         edRq7A0Bq6phx/LMH3GiC1Ngs1AmfCwHURvy9thd+2l15LLDynqcqtCiMd5A2H2/bvCE
         HoNg==
X-Gm-Message-State: AO0yUKXpWh6Z/YKZY4NiidOx+dytrEbiS2fTNBRkjM7rdNRJepbpNgpk
        foPVLfEY/jffvS2TAk9l0jM0/qqVagslEHadT0iNTCxJuYE=
X-Google-Smtp-Source: AK7set+T3+RyfT6ox+DeqQKiji9Fj/UJtuShrZhiEBA8mtPjG9F+oxlVw+R1gPZ5Dk4gCIw6sRmgShBSqD2UgHQbr7Y=
X-Received: by 2002:a17:902:7c94:b0:199:1f95:9ad5 with SMTP id
 y20-20020a1709027c9400b001991f959ad5mr5703797pll.28.1676315081219; Mon, 13
 Feb 2023 11:04:41 -0800 (PST)
MIME-Version: 1.0
References: <CAK3+h2wv6D+ZnOJ9HwXZLF8HN2zcqv2gKn=p3y40z+qoeeiegw@mail.gmail.com>
In-Reply-To: <CAK3+h2wv6D+ZnOJ9HwXZLF8HN2zcqv2gKn=p3y40z+qoeeiegw@mail.gmail.com>
From:   Vincent Li <vincent.mc.li@gmail.com>
Date:   Mon, 13 Feb 2023 11:04:29 -0800
Message-ID: <CAK3+h2wLh5Kq6PvXcRURH6CKEzNcq7gMKz0uriLo9UrpJX4W1w@mail.gmail.com>
Subject: Re: XDP SYNProxy SYN+ACK packet missing?
To:     bpf <bpf@vger.kernel.org>
Cc:     maximmi@nvidia.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Feb 9, 2023 at 10:02 AM Vincent Li <vincent.mc.li@gmail.com> wrote:
>
> Hi,
>
> Sorry for the lengthy and user related question, I configured firehol
> synproxy https://firehol.org/firehol-manual/firehol-synproxy/ to use
> iptables synproxy, which works great. Then I  thought about why not
> use the almost production ready XDP synproxy acceleration code to
> accelerate the synproxy. so I compiled the
> xdp_synproxy.c/xdp_synproxy.kern.bpf.c from bpf-next and copied the
> xdp_synproxy binary and xdp_synproxy.kern.bpf.o to an Ubuntu 20.04
> running Ubuntu PPA mainline kernel 6.1.10
> https://kernel.ubuntu.com/~kernel-ppa/mainline/v6.1.10/
>
> attached the XDP program
>
> root@vli-2004:/home/vincent# ./xdp_synproxy --iface ens192  --mss4
> 1460 --mss6 1440 --ports 80 --wscale 7 --ttl 64 --single
>
> Replacing allowed ports
> Added port 80
> Replacing TCP/IP options
> Total SYNACKs generated: 0
>
> root@vli-2004:/home/vincent# ip l list dev ens192
>
> 3: ens192: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 xdpgeneric qdisc
> mq state UP mode DEFAULT group default qlen 1000
>     link/ether 00:50:56:9d:b2:72 brd ff:ff:ff:ff:ff:ff
>     prog/xdp id 18 tag f895ef43d8481528 jited
>     altname enp11s0
>
> I ran curl test to the target 10.169.72.117 which should be DNAT to
> protected real server 10.1.72.187, it works
>
> I ran client hping3 to send one SYN packet to the target 10.169.72.117
> which should be dropped by XDP SYNPROXY, it works great
>
>  hping3 10.169.72.117 -S -p 80 -c 1
>
> but I did not see SYN+ACK with syncookie packet sent to the client
> when I run tcpdump on the hping3 client side ( I understand I will not
> see SYN and SYN+ACK on firewall with tcpdump because XDP processed
> packet early in the path)
>
> I used pwru to trace the SYN packet:
>
> root@vli-2004:/home/vincent# time ./pwru --filter-src-ip 10.169.72.114
> --output-tuple --backend kprobe-multi
>
>
> 2023/02/09 04:15:42 Per cpu buffer size: 4096 bytes
>
> 2023/02/09 04:15:42 Attaching kprobes (via kprobe-multi)...
>
> 1517 / 1517 [-----------------------------------------------------------------------------------------------------------------------------]
> 100.00% ? p/s
>
> 2023/02/09 04:15:42 Attached (ignored 0)
>
> 2023/02/09 04:15:42 Listening for events..
>
>                SKB    CPU          PROCESS                     FUNC
> 0xffff8fbc5939c900      0        [<empty>]           do_xdp_generic
> 10.169.72.114:17664->10.169.72.117:40(tcp)
> 0xffff8fbc5939c900      0        [<empty>] netif_receive_generic_xdp
> 10.169.72.114:17664->10.169.72.117:40(tcp)
> 0xffff8fbc5939c900      0        [<empty>]         pskb_expand_head
> 10.169.72.114:17664->10.169.72.117:40(tcp)
> 0xffff8fbc5939c900      0        [<empty>]            skb_free_head
> 10.169.72.114:17664->10.169.72.117:40(tcp)
> 0xffff8fbc5939c900      0        [<empty>] bpf_prog_run_generic_xdp
> 10.169.72.114:17664->10.169.72.117:40(tcp)
> 0xffff8fbc5939c900      0        [<empty>]
> kfree_skb_reason(SKB_DROP_REASON_NOT_SPECIFIED)
> 10.169.72.114:17664->10.169.72.117:40(tcp)
> 0xffff8fbc5939c900      0        [<empty>]   skb_release_head_state
> 10.169.72.114:17664->10.169.72.117:40(tcp)
> 0xffff8fbc5939c900      0        [<empty>]         skb_release_data
> 10.169.72.114:17664->10.169.72.117:40(tcp)
> 0xffff8fbc5939c900      0        [<empty>]            skb_free_head
> 10.169.72.114:17664->10.169.72.117:40(tcp)
> 0xffff8fbc5939c900      0        [<empty>]             kfree_skbmem
> 10.169.72.114:17664->10.169.72.117:40(tcp)
>
> This is not big deal since the protection works :)  but I am just
> curious why I did not see the SYN+ACK with syncookie packet sent to
> the hping3 client.
>
> here is my firehol.conf
>
> version 6
>
> # The network of our eth0 LAN.
>
> home_ips="10.1.72.0/24"
> mgmt_ips="10.3.0.0/16"
>
> ipv4 synproxy input inface ens192 dst 10.169.72.117 dport 80 dnat to 10.1.72.187
>
> interface4 ens160 mgmt src "${mgmt_ips}"
>     policy accept
>     server "http ssh icmp"        accept
>     client "icmp"                 accept
>
> interface4 ens224 home src "${home_ips}"
>     policy reject
>     server "http ssh icmp"        accept
>     client "icmp"                 accept
>
> interface4 ens192 internet src not "${home_ips} ${UNROUTABLE_IPS}"
>     protection strong 10/sec 10
>     server "http icmp" accept
>     client all    accept
>
> router4 internet2home inface ens192 outface ens224
>     masquerade reverse
>     server "http" accept dst 10.1.72.187
>     client all   accept
>     server ident reject with tcp-reset
>
>
> Resulting iptables rules related to SYNPROXY
>
> *raw
>
> :PREROUTING ACCEPT [0:0]
> :OUTPUT ACCEPT [0:0]
> :SYNPROXY2SERVER_OUT - [0:0]
> :SYNPROXY2SERVER_PRE - [0:0]
> [0:0] -A PREROUTING -p tcp -m mark --mark 0x2000/0x2000 -j SYNPROXY2SERVER_PRE
> [0:0] -A PREROUTING -d 10.169.72.117/32 -i ens192 -p tcp -m tcp
> --dport 80 -m tcp --tcp-flags FIN,SYN,RST,ACK SYN -j CT --notrack
> [0:0] -A OUTPUT -p tcp -m mark --mark 0x2000/0x2000 -j SYNPROXY2SERVER_OUT
> [0:0] -A SYNPROXY2SERVER_OUT -j ACCEPT
> [0:0] -A SYNPROXY2SERVER_PRE -j ACCEPT
> COMMIT
>
> *nat
>
> :PREROUTING ACCEPT [0:0]
> :INPUT ACCEPT [0:0]
> :OUTPUT ACCEPT [0:0]
> :POSTROUTING ACCEPT [0:0]
> :SYNPROXY2SERVER_OUT - [0:0]
> :SYNPROXY2SERVER_PRE - [0:0]
> [0:0] -A PREROUTING -p tcp -m conntrack --ctstate NEW -m mark --mark
> 0x2000/0x2000 -j SYNPROXY2SERVER_PRE
> [0:0] -A OUTPUT -p tcp -m conntrack --ctstate NEW -m mark --mark
> 0x2000/0x2000 -j SYNPROXY2SERVER_OUT
> [0:0] -A POSTROUTING -o ens192 -m conntrack --ctstate NEW -j MASQUERADE
> [0:0] -A SYNPROXY2SERVER_OUT -d 10.169.72.117/32 -p tcp -m tcp --dport
> 80 -m conntrack --ctstate NEW -j DNAT --to-destination 10.1.72.187
> [0:0] -A SYNPROXY2SERVER_OUT -j ACCEPT
> [0:0] -A SYNPROXY2SERVER_PRE -j ACCEPT
> COMMIT
>
> *mangle
>
> :PREROUTING ACCEPT [0:0]
> :INPUT ACCEPT [0:0]
> :FORWARD ACCEPT [0:0]
> :OUTPUT ACCEPT [0:0]
> :POSTROUTING ACCEPT [0:0]
> [0:0] -A PREROUTING -m conntrack --ctstate RELATED,ESTABLISHED -j
> CONNMARK --restore-mark --nfmask 0x1fff --ctmask 0x1fff
> [0:0] -A INPUT -m conntrack --ctstate NEW -j CONNMARK --save-mark
> --nfmask 0x1fff --ctmask 0x1fff
> [0:0] -A OUTPUT -m conntrack --ctstate RELATED,ESTABLISHED -j CONNMARK
> --restore-mark --nfmask 0x1fff --ctmask 0x1fff
> [0:0] -A OUTPUT -d 10.169.72.117/32 -p tcp -m tcp --dport 80 -m
> conntrack --ctstate NEW -m tcp --tcp-flags FIN,SYN,RST,ACK SYN -j MARK
> --set-xmark 0x2000/0x2000
> [0:0] -A POSTROUTING -m conntrack --ctstate NEW -j CONNMARK
> --save-mark --nfmask 0x1fff --ctmask 0x1fff
> COMMIT
>
> *filter
>
> :INPUT DROP [0:0]
> :FORWARD DROP [0:0]
> :OUTPUT DROP [0:0]
> :SMART_REJECT - [0:0]
> :SYNPROXY2SERVER_IN - [0:0]
> :SYNPROXY2SERVER_OUT - [0:0]
>
> [0:0] -A INPUT -p tcp -m conntrack --ctstate NEW -m mark --mark
> 0x2000/0x2000 -j SYNPROXY2SERVER_IN
> [0:0] -A INPUT -d 10.169.72.117/32 -i ens192 -p tcp -m tcp --dport 80
> -m conntrack --ctstate INVALID,UNTRACKED -j SYNPROXY --sack-perm
> --timestamp --wscale 7 --mss 1460
>
> [0:0] -A FORWARD -s 10.1.72.187/32 -o ens192 -p tcp -m tcp --sport 80
> -m conntrack --ctstate INVALID -m tcp --tcp-flags RST,ACK ACK -j DROP
> [0:0] -A FORWARD -p tcp -m tcp --tcp-flags FIN,ACK FIN,ACK -m
> conntrack --ctstate INVALID,NEW -j DROP
> [0:0] -A FORWARD -p tcp -m tcp --tcp-flags RST,ACK RST,ACK -m
> conntrack --ctstate INVALID,NEW -j DROP
> [0:0] -A FORWARD -p tcp -m tcp --tcp-flags ACK ACK -m conntrack
> --ctstate INVALID,NEW -j DROP
> [0:0] -A FORWARD -p tcp -m tcp --tcp-flags RST RST -m conntrack
> --ctstate INVALID,NEW -j DROP
> [0:0] -A FORWARD -p icmp -m icmp --icmp-type 3 -m conntrack --ctstate
> INVALID,NEW -j DROP
> [0:0] -A FORWARD -m conntrack --ctstate INVALID -m limit --limit 1/sec
> -j LOG --log-prefix "BLOCKED INVALID FORWARD:"
> [0:0] -A FORWARD -m conntrack --ctstate INVALID -j DROP
> [0:0] -A FORWARD -p icmp -m conntrack --ctstate RELATED -j ACCEPT
> [0:0] -A FORWARD -p tcp -m conntrack --ctstate RELATED -m tcp
> --tcp-flags FIN,SYN,RST,PSH,ACK,URG RST,ACK -j ACCEPT
> [0:0] -A FORWARD -m limit --limit 1/sec -j LOG --log-prefix "PASS-unknown:"
> [0:0] -A FORWARD -j DROP
>
> [0:0] -A OUTPUT -p tcp -m conntrack --ctstate NEW -m mark --mark
> 0x2000/0x2000 -j SYNPROXY2SERVER_OUT
> [0:0] -A OUTPUT -s 10.169.72.117/32 -o ens192 -p tcp -m tcp --sport 80
> -m conntrack --ctstate INVALID,UNTRACKED -m tcp --tcp-flags
> SYN,RST,ACK SYN,ACK -j ACCEPT
>
> [0:0] -A SYNPROXY2SERVER_IN -m limit --limit 1/sec -j LOG --log-prefix
> "ORPHAN SYNPROXY->SERVER filte"
> [0:0] -A SYNPROXY2SERVER_IN -j DROP
> [0:0] -A SYNPROXY2SERVER_OUT -d 10.1.72.187/32 -p tcp -m tcp --dport
> 80 -j ACCEPT
> [0:0] -A SYNPROXY2SERVER_OUT -m limit --limit 1/sec -j LOG
> --log-prefix "ORPHAN SYNPROXY->SERVER filte"
> [0:0] -A SYNPROXY2SERVER_OUT -j DROP

after adding bpf_printk in
tools/testing/selftests/bpf/progs/xdp_synproxy_kern.c like

        if (hdr->ipv4) {
                /* TCP doesn't normally use fragments, and XDP can't reassemble
                 * them.
                 */
                if ((hdr->ipv4->frag_off & bpf_htons(IP_DF | IP_MF |
IP_OFFSET)) != bpf_htons(IP_DF)) {
                        bpf_printk("tcp_lookup in syncookie_part1
return 1, fragments\n");
                        return XDP_DROP;
                }

It is my hping3 test  hping3 10.169.72.117 -S -p 80 -c 1 not setting
DF flag and result in above XDP_DROP, so no SYNACK cookie sent, run
hping3 with hping3 10.169.72.117 -S -y -p 80 -c 1 to set DF flag, the
hping3 client received the SYNACK with syncookie. sorry for the noise.
