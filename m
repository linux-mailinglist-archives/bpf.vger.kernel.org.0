Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD3C2447E27
	for <lists+bpf@lfdr.de>; Mon,  8 Nov 2021 11:39:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233642AbhKHKma (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 8 Nov 2021 05:42:30 -0500
Received: from mail-db8eur05on2102.outbound.protection.outlook.com ([40.107.20.102]:46176
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S235338AbhKHKm3 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 8 Nov 2021 05:42:29 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E3C3VYW27BqylYgVZ/wt6c5EnFBlYjCalj7H+8jispX0odDaHQ4yVyORYbpHn2HLaPpHS5+LZUXoaCGB/pNlt9vstNqT46TYx0db9nft7lwUfAyOFHxDG3f10IXfA8+9CTYWRmF/6/Z4XaYGeiyhuvgrpLpG/gEco0PzKIaD/DgfUWYhXHr1oG19KKHtSnmu1XaanlGJP62FFAVFFVlwF443NGFNea4PVzngOlOdfQrWuBA9GobqjGoYQ85LiZpR4n/NCtEGfQD6uAA5Fn0nGEyLX23ZOnzWJwXqmd5DGAifrB5jByuFKK7DVjOBS5dSDUbZzbQ7RZnLwUov4pzqOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Uxf8R5tPHg6QqXOyRVxk3tF0eH4cSe2oo6KQ9GpuYXE=;
 b=Jp9myBTY3LsXU3XyQpRcBMrnVgVZb9NFHRxum8s7BeuKLJ5IZiXG8hHaj7MOwp3p5TmwGm+QQQOJtXLziKf73jWE3d7mG3sBeuEntP6mPxUpF1w0XewRSN1sTrEkjPXCFViLzW2TMT/xkPHIvXS6cld8mXVngNpwyoxBWeQESReVj4sjWEFYSm6XgU7hkJW5giik9Le976vXdvBLktIQDw464LwsjJMxVJl/aB54y/x4BNjKY0tZv2v2Uxgmre+8SWzijOl1jvd+oUlB407b5TK9P0bcbiQOXoQGioOYbfvSUE1MJ+e+uMHJUqwHour/qCNk9En1ubn/ioaV0HnwyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=polito.it; dmarc=pass action=none header.from=polito.it;
 dkim=pass header.d=polito.it; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=politoit.onmicrosoft.com; s=selector2-politoit-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Uxf8R5tPHg6QqXOyRVxk3tF0eH4cSe2oo6KQ9GpuYXE=;
 b=OPbRhVMRaCmD2x4IaZVuLKsalwgd7ea4a8j4Ip88gOqpa4zDLd06nMDTLizxY6JuzRaxwMKQf4MjWB6jID8BlEJGe/G+jauimy6O5wJv26uFyd4zM1bDU+G2hLGVokio1RItkayJycqqM3QA8r2gF12xeueoHMkc1JPJmeLbxFo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=polito.it;
Received: from AM6PR05MB5223.eurprd05.prod.outlook.com (2603:10a6:20b:68::17)
 by AS8PR05MB7877.eurprd05.prod.outlook.com (2603:10a6:20b:258::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.10; Mon, 8 Nov
 2021 10:39:43 +0000
Received: from AM6PR05MB5223.eurprd05.prod.outlook.com
 ([fe80::50a7:7a0b:413a:864c]) by AM6PR05MB5223.eurprd05.prod.outlook.com
 ([fe80::50a7:7a0b:413a:864c%6]) with mapi id 15.20.4669.016; Mon, 8 Nov 2021
 10:39:43 +0000
Message-ID: <36467ea3-8b19-f385-c2d0-02e2bd9c934e@polito.it>
Date:   Mon, 8 Nov 2021 11:39:42 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Content-Language: en-US
To:     bpf@vger.kernel.org
From:   Federico Parola <federico.parola@polito.it>
Subject: Add variable offset to packet pointer in XDP/TC programs
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: ZR0P278CA0066.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:21::17) To AM6PR05MB5223.eurprd05.prod.outlook.com
 (2603:10a6:20b:68::17)
MIME-Version: 1.0
Received: from [192.168.1.61] (93.88.125.241) by ZR0P278CA0066.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:21::17) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.11 via Frontend Transport; Mon, 8 Nov 2021 10:39:43 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0647be3c-208b-48b2-b6b9-08d9a2a4138d
X-MS-TrafficTypeDiagnostic: AS8PR05MB7877:
X-Microsoft-Antispam-PRVS: <AS8PR05MB787795B9056785FF79326BFFF2919@AS8PR05MB7877.eurprd05.prod.outlook.com>
X-POLITOEOL-test: CGP-Message-politoit
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yiudEdG6bQxF9gc9LjtfKGIYV4A8uO1vBXnKCkx61GEzd4+dVhr35FI2w2cwJESLpFY4u/C/j0mrqa45cOkumlMbLlLdLk2NoaQbSfpSPg3Xqi7bBEsGlQtE78/rNMWeTLbLw1keR5Uj7Su1Q9bLZOT9H/1NFrad5AioOIClyvsYEAeNEL0BlgloIRoNUERLzz0sGlJrwTv8QKoeIPeP8WoUDtg941aFQXS8u5LFqombjxxEz2gv4Jg8/J5kqts1+BjsOaR7em/7MNk/UGp2gqwrWubGQdSg71uN9JtE6RtL4rweBlSw4QUvRBYn6Rg8u8pw8+qMKODSxyRXxo9jqN8ZALZgsHjILVwuea1iiS9y/ApLIZvQwWVx1RMqBv+kTRipnsssYuQZc43z+WUujj9WtK8aGeuHSIUwLLLs7FZqSFFzNoJqcnMcDcsLGAYFakTerSgm9O2K6QmvqAu0rf6K9knS2yjvJTFZhatJ0mxLQOvtV/vMX/QbB/IgsHKGCCUoHVK3XbqzA9FKwE3g2jEXUj/w1/IhxCMq5vf5CFjmL1UdMhH24WUx1sBMmXuWQJYUOuU+Vc8OGe5X9DchMe4MF1w2tXYd4to29LxxHZ/dkLTNzCkcWc5Pq8abC5AX8G8wNav4e0ps9j0ERuSlEOnEFk6A+h651iChaVap2r4sPA79JT7icxgNpelENs+7D06weOQgtz3cTWazzxx9I8Fpn8fh+UDri7pa+ln+O3dPm9WVO9F2gIOnfMAEzJIvHpixRO0/1mgDkx7PpCf0On3pE66gPtlD36pP400bHWFq9qM1cZpQEvTR46CVqNRgxxoCl42bFfdcDAen4LXpsA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR05MB5223.eurprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(2906002)(36756003)(31686004)(66946007)(6916009)(956004)(66556008)(66476007)(52116002)(6486002)(38350700002)(38100700002)(31696002)(186003)(508600001)(966005)(5660300002)(8676002)(86362001)(2616005)(83380400001)(44832011)(16576012)(26005)(786003)(316002)(8936002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SFBuWW5DdW9kQzFNajFKNDE5aytEM2FhaVZxL3p3TEI0VmdEaWpPSmJzRWFm?=
 =?utf-8?B?M240MGo0MmNXU095YVVYaWxKQm4vTEZGcTJITlllSm1TY0hqUVFBNU1KZU9N?=
 =?utf-8?B?VndJOWF3blYyVTdoZCtLbk5XRDNBYjVGOWZlTHNzQi9vOXpJNFNjUGhqWnBR?=
 =?utf-8?B?ZzFZUjM4Z1V1d2svSHNEWjcyTlVWTmllSVdOZUkxbFFEb2VVY2FWeHJOU05l?=
 =?utf-8?B?SGk4c0hEWFp0OVhMa3hqbmQ0QTVmQVRPdS9YSktWSzhWamEwMm5xTkNnaG16?=
 =?utf-8?B?aS8ya0JhNmxGRzVjbXJIVENPWnlLeGo5RHE0c0dOZCtHQzFuRkhSdks2Q3BW?=
 =?utf-8?B?S3B5Y0NqYm1McTNBaEFnb2U2ZlpyYkxJUUswYkh6eEJHbmJoTm1EZFdERWR5?=
 =?utf-8?B?MWFXc0UvUnNBdm1DVDIzWHdSRjFpbHNsZXF3VENOVlNFSmVkZU0wYk5lK01R?=
 =?utf-8?B?MnpMTFRIRTBDYXdSa3Z0MC9yM0lMT3liRHFYbWpQclo1RlIzcnBOTDRQZTB1?=
 =?utf-8?B?YUZGSzdack5lUnNDdlNEb1YrYnNhaEJPRzFsSHJiZ0lKZGk4SC9ER2hPdWZz?=
 =?utf-8?B?SGZpRnRnNG93RGc2VXAyQkNvK3FURDhLZEl5SHRoWU5lc0lLR0UxL1ZDMVpV?=
 =?utf-8?B?MzEzUklPblJIOHJIUDRQbmdVcC8vV08zOGtmTFJncXMrNk0rcXA0MytvYkhr?=
 =?utf-8?B?WUtvRXZsNllzYkNjaVNXRlViRldMYkN4NWRPVkdZc2s1b3VJOFJXSHNXdWUz?=
 =?utf-8?B?N0xBMnFEdjViRi93OG1PakFtdkg0Q2xaL2tBVTNnNmE1VzFGdGh0a1NBMjV5?=
 =?utf-8?B?WTBpUFZQR0RFUXM0Qy95WUlZQk9RZGUzcVpBN2tDRXZBMUhTVTBrT3RvKzFE?=
 =?utf-8?B?ZTF4cklSMEU3ajBoWTVqUlpaa3dFOUlrd3NtU1hZRUdBTmcyMXNiWDhyN0RV?=
 =?utf-8?B?aWpOMmNKR1V5WnFZL2ZrdzE3eGtUb2l2U3hNVDZvT1FQT3BzQW9MbDBGN3Nv?=
 =?utf-8?B?UWR5MW5NZXozV0M3UG5pVVlERG0vc0NLOE5aRkhoTW5hbEJrMmRwVXZSMUkv?=
 =?utf-8?B?YjVzN05waXBXZkxMNDdxTWdPZ1U4TXpFN2FrbW1rd2t3Q0QxYUdGMGJQR0JE?=
 =?utf-8?B?MzE4bnVsTHJqL3dJQ2pWeEdaUkVheEoyTkpzbElRN0FZVWk1M2gyK3g4TTMy?=
 =?utf-8?B?bndyQlFSZGhNQzcyRU9tdGsycVdJZ3Vwdk5tRnlhcjdWZURHVU93aHdsbnpJ?=
 =?utf-8?B?UVFlemNkMXFUN2svcE1aZ3BRanEwR0RIWExLT2pPZ2VNUXFabzVPckpOZEhG?=
 =?utf-8?B?d3VEcXlhejBqTjJITWx2UXM5aHFkV2w0M3EvNFhWVmNDaE5mVU5TR1FTcGM0?=
 =?utf-8?B?ZFJ1VzZ4b3RoU28zTU1yWHFUNUlYMzViQ3ZVNnVYa0xKUWk0czh1TGxRcmpG?=
 =?utf-8?B?U0RrcVRWekdybmhSRnJEQzc1cnUrOG9KanZaMXE4Y0FIeVBsZnFNQmN4Q1FV?=
 =?utf-8?B?b280RmszSUpOeVYxRHhsTTFHa1FOQitQSmcyY3VKNUR4dUFJMHlmRWxNYkZv?=
 =?utf-8?B?WnI3eGxUemY0TE1QYm5kdTFUT2M4eHpFOFhpckFwN2FORmlQdDhMcWxNNlk3?=
 =?utf-8?B?TXpSbmdZdWkyWHI5WUdIcnozWmpmMWM1dFJzQmpoSmVKVW9IYmZpQ2htMDJZ?=
 =?utf-8?B?Qzh2Z05kQjYycVNZU1h6MyszcitBc0lKdGk3cVRxMkg3R2NyRjhieEc2Z1BJ?=
 =?utf-8?B?TC9tb2FKWTFVWllVZ0VnMmFiRmZyUjh4aXRKKy82OU8wNXpibGFETnl3eWNH?=
 =?utf-8?B?Rk5NZHhPUVpSTy9kWTk4Ym9uaWxOaUVHbDRnRGZiR29SM05qRDlITFpEbWpz?=
 =?utf-8?B?Sk9zeWJxZlUwd2V1OCtNM3ZVaE1yanQ4TnBuSDhZZEFLa1RQSnVETktQU0dC?=
 =?utf-8?B?ZW9rYmt5T3ZiMXZIQUpueU9sSDBXemZYK2RBNUNBdVFxUEgrUE5saC9wRHdO?=
 =?utf-8?B?blNybXU2ZFB1OWlxMlIxYXYyY09scDdhcVBMWStoM3J5UEZtenhjRVFDMDVw?=
 =?utf-8?B?MUxxUDc5Z0VZMEE4WHFxQko0K2lWamIvdHd0NDJ6TlFzaExyaXM2ak5qR1RX?=
 =?utf-8?B?SUtKRm1hUm5sd1J5a1VGSldNdXFrMml4cDNjWGNwd2gvRU9QR0JJUzdLUFUw?=
 =?utf-8?B?SWF4MlZrOVVrMHNmUm1mcjExRzBXTXg4S2JBcm8vR2VwVDIzeUNzU0NpVjFI?=
 =?utf-8?B?cERGUncvaUtzaWNyalZobW9LcVFBPT0=?=
X-OriginatorOrg: polito.it
X-MS-Exchange-CrossTenant-Network-Message-Id: 0647be3c-208b-48b2-b6b9-08d9a2a4138d
X-MS-Exchange-CrossTenant-AuthSource: AM6PR05MB5223.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2021 10:39:43.7305
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 2a05ac92-2049-4a26-9b34-897763efc8e2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wXLzzzxFD/CkLvR5/QaHoMCA/9GMESpHwq+XtKoRkRvoIyHxCJZmJ1CaszMklMSzP0GOp2PlGXplKI5xbKjBDQ8z9oz+8hj/oTrmqP/v5Tg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR05MB7877
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Dear all,
I found out that every time an offset stored in a 2 (or more) bytes 
variable is added to a packet pointer subsequent checks against packet 
boundaries become ineffective.
Here is a toy example to test the problem (it doesn't do anything useful):

int test(struct __sk_buff *ctx) {
     void *data = (void *)(long)ctx->data;
     void *data_end = (void *)(long)ctx->data_end;

     /* Skipping an amount of bytes stored in __u8 works */
     if (data + sizeof(__u8) > data_end)
         return TC_ACT_OK;
     bpf_trace_printk("Skipping %d bytes", *(__u8 *)data);
     data += *(__u8 *)data;

     /* Skipping an amount of bytes stored in __u16 works but... */
     if (data + sizeof(__u16) > data_end)
         return TC_ACT_OK;
     bpf_trace_printk("Skipping %d bytes", *(__u16 *)data);
     data += *(__u16 *)data;

     /* ...this check is not effective and packet access is rejected */
     if (data + sizeof(__u8) > data_end)
         return TC_ACT_OK;
     bpf_trace_printk("Next byte is %x", *(__u8 *)data);

     return TC_ACT_OK;
}

My practical use case would be skipping variable-size TLS header 
extensions until I reach the desired one (the length of these options is 
2 bytes long).
Another use case can be found here: 
https://lists.iovisor.org/g/iovisor-dev/topic/access_packet_payload_in_tc/86442134
After I use the bpf_skb_pull_data() I would like to directly jump to the 
part of packet I was working on and avoid re-parsing everything from 
scratch, however if I save the offset in a 2 bytes variable and then add 
it to the packet pointer I'm no longer able to access it (if the offset 
is stored in a 1 byte var everything works).

Is this a verifier bug?

Best regards,
Federico Parola
