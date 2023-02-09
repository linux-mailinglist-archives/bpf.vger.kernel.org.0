Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBABF690FD2
	for <lists+bpf@lfdr.de>; Thu,  9 Feb 2023 19:02:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230245AbjBISCs (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 9 Feb 2023 13:02:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230259AbjBISCp (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 9 Feb 2023 13:02:45 -0500
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9ECA645219
        for <bpf@vger.kernel.org>; Thu,  9 Feb 2023 10:02:41 -0800 (PST)
Received: by mail-pl1-x635.google.com with SMTP id z1so3725210plg.6
        for <bpf@vger.kernel.org>; Thu, 09 Feb 2023 10:02:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Ln0g7w4oqlNhsZQhqyQ8lclO74u/J8hFDhcCp3K8mTQ=;
        b=nausA29Fo+6rTP317RVYT0Tw+fOsllaz8aKOhpG7IInO4x18lhC8QPyAbP+t3IjLDb
         DCGpnq4Bx001F5jaJ0hOPHgdnAH9krE4WJ9nRLgdZxCsYnf4M4/4cIT+yy+K1lH3dxIY
         6sQfsLC9bKZxg3t5EmVAIxWVBG5+J6ZBsIv4/gBYUx4JNx9Ab5NyuORjPpgbfXI0IRFO
         6fAwiKewAnG9e5EdrcLO8D85vlAV28gyy2XR1+YG/NaNFltnp1zKYOjwNy0UgvNpdtMj
         kw4q8Nw27iySxWTb4xPJw1rq2qU4aMdhO/paLonj72W1VmG8xUGezEK/Q7CuI/hzhcVW
         YM9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ln0g7w4oqlNhsZQhqyQ8lclO74u/J8hFDhcCp3K8mTQ=;
        b=2oUJGYxKNXy9O0yvCMGYYDR6KkbQREVEUdTmSP1NWdpCGKWXFmzZ97/+fjJqHi0bRd
         6FdbNJjHoU2AeQHhYocv0cP1Ivby5Zy7xnAMr7GEue23iGqPuVDjtSeRhGvOd6fEWFaa
         lxuK6YCsSEXxtAABDGIeomotSV4lcPFf6kz82uChp353KM1r+qGvDwYh5BzwgdEJvpZm
         Gfl/32VjMd5VamE+4S1aVTb4ycL+sYvw4iD+Kgb5SXzi6fXnQNJaBBMT2sp+3JXzIktd
         CqI2TpXow3zyoVcgO2h1XN/w+NWiKrP85NBoyGfkChQnuk5w1KgfOdmObcEz9n9p87EG
         iV0g==
X-Gm-Message-State: AO0yUKWLxJ3ffg1LyAA3eSDZoYspFJrkzX63JaMHaYExbZB0FZAMPtwK
        ZDqj8QQqLZSZ/so2OxqtKKZ+YAIlk9InN8NUVbmi1X3lgfo=
X-Google-Smtp-Source: AK7set/yu4l2Lo/BxzTV0yy/CvwJzfxokefGqzdZdwZoz2FFp9szlCbJrBaR2JVvyJGUHB6vT/Yp0NcpApVUT0tiMRY=
X-Received: by 2002:a17:902:76c6:b0:199:4934:9d1b with SMTP id
 j6-20020a17090276c600b0019949349d1bmr1770215plt.23.1675965760415; Thu, 09 Feb
 2023 10:02:40 -0800 (PST)
MIME-Version: 1.0
From:   Vincent Li <vincent.mc.li@gmail.com>
Date:   Thu, 9 Feb 2023 10:02:28 -0800
Message-ID: <CAK3+h2wv6D+ZnOJ9HwXZLF8HN2zcqv2gKn=p3y40z+qoeeiegw@mail.gmail.com>
Subject: XDP SYNProxy SYN+ACK packet missing?
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

Hi,

Sorry for the lengthy and user related question, I configured firehol
synproxy https://firehol.org/firehol-manual/firehol-synproxy/ to use
iptables synproxy, which works great. Then I  thought about why not
use the almost production ready XDP synproxy acceleration code to
accelerate the synproxy. so I compiled the
xdp_synproxy.c/xdp_synproxy.kern.bpf.c from bpf-next and copied the
xdp_synproxy binary and xdp_synproxy.kern.bpf.o to an Ubuntu 20.04
running Ubuntu PPA mainline kernel 6.1.10
https://kernel.ubuntu.com/~kernel-ppa/mainline/v6.1.10/

attached the XDP program

root@vli-2004:/home/vincent# ./xdp_synproxy --iface ens192  --mss4
1460 --mss6 1440 --ports 80 --wscale 7 --ttl 64 --single

Replacing allowed ports
Added port 80
Replacing TCP/IP options
Total SYNACKs generated: 0

root@vli-2004:/home/vincent# ip l list dev ens192

3: ens192: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 xdpgeneric qdisc
mq state UP mode DEFAULT group default qlen 1000
    link/ether 00:50:56:9d:b2:72 brd ff:ff:ff:ff:ff:ff
    prog/xdp id 18 tag f895ef43d8481528 jited
    altname enp11s0

I ran curl test to the target 10.169.72.117 which should be DNAT to
protected real server 10.1.72.187, it works

I ran client hping3 to send one SYN packet to the target 10.169.72.117
which should be dropped by XDP SYNPROXY, it works great

 hping3 10.169.72.117 -S -p 80 -c 1

but I did not see SYN+ACK with syncookie packet sent to the client
when I run tcpdump on the hping3 client side ( I understand I will not
see SYN and SYN+ACK on firewall with tcpdump because XDP processed
packet early in the path)

I used pwru to trace the SYN packet:

root@vli-2004:/home/vincent# time ./pwru --filter-src-ip 10.169.72.114
--output-tuple --backend kprobe-multi


2023/02/09 04:15:42 Per cpu buffer size: 4096 bytes

2023/02/09 04:15:42 Attaching kprobes (via kprobe-multi)...

1517 / 1517 [-----------------------------------------------------------------------------------------------------------------------------]
100.00% ? p/s

2023/02/09 04:15:42 Attached (ignored 0)

2023/02/09 04:15:42 Listening for events..

               SKB    CPU          PROCESS                     FUNC
0xffff8fbc5939c900      0        [<empty>]           do_xdp_generic
10.169.72.114:17664->10.169.72.117:40(tcp)
0xffff8fbc5939c900      0        [<empty>] netif_receive_generic_xdp
10.169.72.114:17664->10.169.72.117:40(tcp)
0xffff8fbc5939c900      0        [<empty>]         pskb_expand_head
10.169.72.114:17664->10.169.72.117:40(tcp)
0xffff8fbc5939c900      0        [<empty>]            skb_free_head
10.169.72.114:17664->10.169.72.117:40(tcp)
0xffff8fbc5939c900      0        [<empty>] bpf_prog_run_generic_xdp
10.169.72.114:17664->10.169.72.117:40(tcp)
0xffff8fbc5939c900      0        [<empty>]
kfree_skb_reason(SKB_DROP_REASON_NOT_SPECIFIED)
10.169.72.114:17664->10.169.72.117:40(tcp)
0xffff8fbc5939c900      0        [<empty>]   skb_release_head_state
10.169.72.114:17664->10.169.72.117:40(tcp)
0xffff8fbc5939c900      0        [<empty>]         skb_release_data
10.169.72.114:17664->10.169.72.117:40(tcp)
0xffff8fbc5939c900      0        [<empty>]            skb_free_head
10.169.72.114:17664->10.169.72.117:40(tcp)
0xffff8fbc5939c900      0        [<empty>]             kfree_skbmem
10.169.72.114:17664->10.169.72.117:40(tcp)

This is not big deal since the protection works :)  but I am just
curious why I did not see the SYN+ACK with syncookie packet sent to
the hping3 client.

here is my firehol.conf

version 6

# The network of our eth0 LAN.

home_ips="10.1.72.0/24"
mgmt_ips="10.3.0.0/16"

ipv4 synproxy input inface ens192 dst 10.169.72.117 dport 80 dnat to 10.1.72.187

interface4 ens160 mgmt src "${mgmt_ips}"
    policy accept
    server "http ssh icmp"        accept
    client "icmp"                 accept

interface4 ens224 home src "${home_ips}"
    policy reject
    server "http ssh icmp"        accept
    client "icmp"                 accept

interface4 ens192 internet src not "${home_ips} ${UNROUTABLE_IPS}"
    protection strong 10/sec 10
    server "http icmp" accept
    client all    accept

router4 internet2home inface ens192 outface ens224
    masquerade reverse
    server "http" accept dst 10.1.72.187
    client all   accept
    server ident reject with tcp-reset


Resulting iptables rules related to SYNPROXY

*raw

:PREROUTING ACCEPT [0:0]
:OUTPUT ACCEPT [0:0]
:SYNPROXY2SERVER_OUT - [0:0]
:SYNPROXY2SERVER_PRE - [0:0]
[0:0] -A PREROUTING -p tcp -m mark --mark 0x2000/0x2000 -j SYNPROXY2SERVER_PRE
[0:0] -A PREROUTING -d 10.169.72.117/32 -i ens192 -p tcp -m tcp
--dport 80 -m tcp --tcp-flags FIN,SYN,RST,ACK SYN -j CT --notrack
[0:0] -A OUTPUT -p tcp -m mark --mark 0x2000/0x2000 -j SYNPROXY2SERVER_OUT
[0:0] -A SYNPROXY2SERVER_OUT -j ACCEPT
[0:0] -A SYNPROXY2SERVER_PRE -j ACCEPT
COMMIT

*nat

:PREROUTING ACCEPT [0:0]
:INPUT ACCEPT [0:0]
:OUTPUT ACCEPT [0:0]
:POSTROUTING ACCEPT [0:0]
:SYNPROXY2SERVER_OUT - [0:0]
:SYNPROXY2SERVER_PRE - [0:0]
[0:0] -A PREROUTING -p tcp -m conntrack --ctstate NEW -m mark --mark
0x2000/0x2000 -j SYNPROXY2SERVER_PRE
[0:0] -A OUTPUT -p tcp -m conntrack --ctstate NEW -m mark --mark
0x2000/0x2000 -j SYNPROXY2SERVER_OUT
[0:0] -A POSTROUTING -o ens192 -m conntrack --ctstate NEW -j MASQUERADE
[0:0] -A SYNPROXY2SERVER_OUT -d 10.169.72.117/32 -p tcp -m tcp --dport
80 -m conntrack --ctstate NEW -j DNAT --to-destination 10.1.72.187
[0:0] -A SYNPROXY2SERVER_OUT -j ACCEPT
[0:0] -A SYNPROXY2SERVER_PRE -j ACCEPT
COMMIT

*mangle

:PREROUTING ACCEPT [0:0]
:INPUT ACCEPT [0:0]
:FORWARD ACCEPT [0:0]
:OUTPUT ACCEPT [0:0]
:POSTROUTING ACCEPT [0:0]
[0:0] -A PREROUTING -m conntrack --ctstate RELATED,ESTABLISHED -j
CONNMARK --restore-mark --nfmask 0x1fff --ctmask 0x1fff
[0:0] -A INPUT -m conntrack --ctstate NEW -j CONNMARK --save-mark
--nfmask 0x1fff --ctmask 0x1fff
[0:0] -A OUTPUT -m conntrack --ctstate RELATED,ESTABLISHED -j CONNMARK
--restore-mark --nfmask 0x1fff --ctmask 0x1fff
[0:0] -A OUTPUT -d 10.169.72.117/32 -p tcp -m tcp --dport 80 -m
conntrack --ctstate NEW -m tcp --tcp-flags FIN,SYN,RST,ACK SYN -j MARK
--set-xmark 0x2000/0x2000
[0:0] -A POSTROUTING -m conntrack --ctstate NEW -j CONNMARK
--save-mark --nfmask 0x1fff --ctmask 0x1fff
COMMIT

*filter

:INPUT DROP [0:0]
:FORWARD DROP [0:0]
:OUTPUT DROP [0:0]
:SMART_REJECT - [0:0]
:SYNPROXY2SERVER_IN - [0:0]
:SYNPROXY2SERVER_OUT - [0:0]

[0:0] -A INPUT -p tcp -m conntrack --ctstate NEW -m mark --mark
0x2000/0x2000 -j SYNPROXY2SERVER_IN
[0:0] -A INPUT -d 10.169.72.117/32 -i ens192 -p tcp -m tcp --dport 80
-m conntrack --ctstate INVALID,UNTRACKED -j SYNPROXY --sack-perm
--timestamp --wscale 7 --mss 1460

[0:0] -A FORWARD -s 10.1.72.187/32 -o ens192 -p tcp -m tcp --sport 80
-m conntrack --ctstate INVALID -m tcp --tcp-flags RST,ACK ACK -j DROP
[0:0] -A FORWARD -p tcp -m tcp --tcp-flags FIN,ACK FIN,ACK -m
conntrack --ctstate INVALID,NEW -j DROP
[0:0] -A FORWARD -p tcp -m tcp --tcp-flags RST,ACK RST,ACK -m
conntrack --ctstate INVALID,NEW -j DROP
[0:0] -A FORWARD -p tcp -m tcp --tcp-flags ACK ACK -m conntrack
--ctstate INVALID,NEW -j DROP
[0:0] -A FORWARD -p tcp -m tcp --tcp-flags RST RST -m conntrack
--ctstate INVALID,NEW -j DROP
[0:0] -A FORWARD -p icmp -m icmp --icmp-type 3 -m conntrack --ctstate
INVALID,NEW -j DROP
[0:0] -A FORWARD -m conntrack --ctstate INVALID -m limit --limit 1/sec
-j LOG --log-prefix "BLOCKED INVALID FORWARD:"
[0:0] -A FORWARD -m conntrack --ctstate INVALID -j DROP
[0:0] -A FORWARD -p icmp -m conntrack --ctstate RELATED -j ACCEPT
[0:0] -A FORWARD -p tcp -m conntrack --ctstate RELATED -m tcp
--tcp-flags FIN,SYN,RST,PSH,ACK,URG RST,ACK -j ACCEPT
[0:0] -A FORWARD -m limit --limit 1/sec -j LOG --log-prefix "PASS-unknown:"
[0:0] -A FORWARD -j DROP

[0:0] -A OUTPUT -p tcp -m conntrack --ctstate NEW -m mark --mark
0x2000/0x2000 -j SYNPROXY2SERVER_OUT
[0:0] -A OUTPUT -s 10.169.72.117/32 -o ens192 -p tcp -m tcp --sport 80
-m conntrack --ctstate INVALID,UNTRACKED -m tcp --tcp-flags
SYN,RST,ACK SYN,ACK -j ACCEPT

[0:0] -A SYNPROXY2SERVER_IN -m limit --limit 1/sec -j LOG --log-prefix
"ORPHAN SYNPROXY->SERVER filte"
[0:0] -A SYNPROXY2SERVER_IN -j DROP
[0:0] -A SYNPROXY2SERVER_OUT -d 10.1.72.187/32 -p tcp -m tcp --dport
80 -j ACCEPT
[0:0] -A SYNPROXY2SERVER_OUT -m limit --limit 1/sec -j LOG
--log-prefix "ORPHAN SYNPROXY->SERVER filte"
[0:0] -A SYNPROXY2SERVER_OUT -j DROP
