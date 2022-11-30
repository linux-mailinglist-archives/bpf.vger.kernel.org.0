Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 055A663E38E
	for <lists+bpf@lfdr.de>; Wed, 30 Nov 2022 23:39:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229684AbiK3Wje (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 30 Nov 2022 17:39:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229688AbiK3Wjd (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 30 Nov 2022 17:39:33 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AC428E588
        for <bpf@vger.kernel.org>; Wed, 30 Nov 2022 14:39:31 -0800 (PST)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2AULwp66030651;
        Wed, 30 Nov 2022 22:38:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=K0amHBkT/Y8CM54rZZEAVaRIZZODYeOPmVBRryingfs=;
 b=Imdsw50pIm0N5bb10Oeef9k78W3bevWVeWaD6At/Ftv0wVtPJ1ucZAgc7jM7lTH+DSs3
 sURe67p8b5JoUoUUG8cBeYr8qDpAzy+UpPUrhJ6FkaC9hwUvaPYzJK1/LpZfGhAogoBv
 q3n71EXdTE1e1kE79Y8VHWq58IaDt79UPo3q1MInlniYjJbETQ/js8d5gwyLKvDUVL0V
 0yRJ6vOF4NpkDS/V8bjh8YE0207wP6NeS04GLclFFw1KSvzfSaB2QnbaWeGHAr0ikhts
 +PQMeC9a8hJy8GWWKcl6XtF7+VrHg90G5UXd2lV9S3yk/QJl0trKy6Zt981VLt1I31/t dg== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3m40y42yun-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 30 Nov 2022 22:38:51 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2AUM9ljL007614;
        Wed, 30 Nov 2022 22:34:22 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2172.outbound.protection.outlook.com [104.47.55.172])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3m3989qpxj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 30 Nov 2022 22:34:22 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GBFEdfp2Cle9kdG+3HTeuB2fPTJKed9K56a1fLJbo5BY2UaqarSv1Hp/IryVAqaPLnyWCZgCx6rgW1GM88uOFCjP3H2FTx8rttfdque7ouFKdFyB8gMJayeqf9NS4GJx6plWLHE5UOZzTVpobFVmoAAh0vwiTc1qyVQ92IdJ5d1qii4V+apC/7vNltTiDm6xQb3VJIGKNkxt+MZgMgyamkq5igXlEFHwLvzLTeU7mv94/S3hi++DH5S/eV5YMfzk14KtqMfV0v6ZwsS6OYQ+YDRrbDKkFf7z1/pKGS1t+Cgy8nwZgCgttMDSGRVvVn7Kn9lIgh00BVbpQcj150hSOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K0amHBkT/Y8CM54rZZEAVaRIZZODYeOPmVBRryingfs=;
 b=LCr9bU7ohNquwMs+/IwauIXQYL96A3ZKD8jHclK2zB4z4XlUMPA2syJggrVlFi6z2u/K5MrQSciizjAi14skXRY0IT9pj+WJmglhCUEIAXvYHbzyGzZwqcOqm/Luyz81WmlCc30GmgjsNffIZzf0MvtwDpE3ptpVdee1wj1GY/w5n26ajWr6DHU/fuehsjzBgl8jM6bluD7wWoKJSWv39gsQSdbUrEf7XWNZyn5L9kRTHrCWvOX1yITYDOqsdpPfh3q3uSk4mIP3iZ72ZZ7JamEqf84vsM7lPtJ9aomvA67yjAxMVM50kp4HwZ2zK8tYRGNzUZCITflSEwzc10rrDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K0amHBkT/Y8CM54rZZEAVaRIZZODYeOPmVBRryingfs=;
 b=Qe3k+5pKquU6d7lQf+rZFSUFhhkXIc+QksBpGIluJi4FsrWs7j6GoyffHHO6iIW3fS6pZDPNLpn6WzoCfkkRV7JR0g7gI7aEsFcIbeUMtyvGNRLJ6pAdiA9BZ4NmS7GDJvoCZbXM50+xXom98ZdQ3NJmdlfmz2+15U8f2NN/Aew=
Received: from BLAPR10MB5267.namprd10.prod.outlook.com (2603:10b6:208:30e::22)
 by PH7PR10MB6204.namprd10.prod.outlook.com (2603:10b6:510:1f0::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.23; Wed, 30 Nov
 2022 22:34:19 +0000
Received: from BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::d44e:a833:13b5:4119]) by BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::d44e:a833:13b5:4119%9]) with mapi id 15.20.5857.023; Wed, 30 Nov 2022
 22:34:19 +0000
Subject: Re: [RFC bpf-next 2/5] libbpf: provide libbpf API to encode BTF kind
 information
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     andrii@kernel.org, ast@kernel.org, daniel@iogearbox.net,
        martin.lau@linux.dev, song@kernel.org, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, mykolal@fb.com,
        haiyue.wang@intel.com, bpf@vger.kernel.org
References: <1669225312-28949-1-git-send-email-alan.maguire@oracle.com>
 <1669225312-28949-3-git-send-email-alan.maguire@oracle.com>
 <CAEf4BzZtOUXxKurpmHzsZ+8FP6aahUNEmcPz=Rr=gkuQPu0yaA@mail.gmail.com>
 <658aa4e6-d1ea-c518-0c0d-318811eb48fd@oracle.com>
 <CAEf4Bzb0Se8n4uO1UDWzQf3t_eYF6Eor8_nRqO5QR77Cdp669A@mail.gmail.com>
From:   Alan Maguire <alan.maguire@oracle.com>
Message-ID: <d51186d9-076b-1905-97f6-4debea92d3ed@oracle.com>
Date:   Wed, 30 Nov 2022 22:34:13 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.3
In-Reply-To: <CAEf4Bzb0Se8n4uO1UDWzQf3t_eYF6Eor8_nRqO5QR77Cdp669A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P265CA0253.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:37c::6) To BLAPR10MB5267.namprd10.prod.outlook.com
 (2603:10b6:208:30e::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB5267:EE_|PH7PR10MB6204:EE_
X-MS-Office365-Filtering-Correlation-Id: b7d676ef-7dc3-4b55-2cf3-08dad32304ff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: E4/I4OGjYRqnl3BiJ5Lcv4pm/mOx5bfh/P9uqj54guhM/FCSSwNTGC1vcIftn793B/LL2gt8gtxV3C8KEFNq/2DPtyehNbijYczeQGMPRz9EULOItCEHmmHk3PPnBC44GBDdcbxVI4JYho+Otv0qkaqgF8/Lkc4A2SR8hd6PAa303Rrb2zhiSu+cbI9dWK+pGbUBtRrCP6eHsxFzp4WtC2IxdJ8tYr6prwfLpIk61dOcYDY4dSzk3pdjrRBpeww5UD5byRgz9ZqBCe3PoZA+etDWB9F9T7gcrQ//oECmKg3XsS7BMjDMC4T96pOLz6wJoCi6cKoMw6ieHzz9QNoq2N3IBg3d2s7KDwnmEE85hKsGWF8i/ERuOW4OQFhUDtWxari8RjTZzBEi62xLFlk7iJx4frvHMreqMXugj0Lc+n7E0uKDOwl51o+druyj2wXZCFJy+epVJQQ0JsTTnyYQOGYNNTDA2yZaIINZrdL4DWGL2kfpjzAdvE2VBlNY0srjC8kiHQk6OigO+7NzM0qJhbAbFvPyzcGxmRIeSuaG55pyf+d1p4EuEHsuGoJ754qAWAFDtCqZ7r724kPKxbvcuGyGCYb9Bbcoz/62sSbPT55vfKMwOhF+uEDfcMrGLF/DWyvdWaRwnmA35snSmZT1Sn4gbTqWEjJurO5hd4BtpSnKS5Pj9Po2+g/jDtzCnWC17lNmPM1r+Ethcc4PyjYMbNgAHxfl3AewBhqzsu2nyBGLJHXNkI2mnONdWCXdCPsG
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5267.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(396003)(376002)(346002)(39860400002)(366004)(451199015)(41300700001)(8936002)(5660300002)(7416002)(2906002)(31686004)(316002)(6916009)(66946007)(66556008)(83380400001)(6486002)(966005)(66476007)(478600001)(4326008)(36756003)(6666004)(86362001)(2616005)(6512007)(53546011)(186003)(31696002)(30864003)(6506007)(44832011)(8676002)(38100700002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?M3Z2OXhCNE5TUStCSkpiN3JjMUlWaXdBRmROVnR3aUgzejF3dXJvampPdHc4?=
 =?utf-8?B?WFVHamtQYWYwRzIxZytXY2JtUkt1UHh6ZUtPQkVxWTR3S0VzcjMxOUJnTXd2?=
 =?utf-8?B?N3kwUmx5SGd6NGROMHpNYklQTysvR1JkQ1RRK3BxaGZRTmN1ZGZaTWJ2eU94?=
 =?utf-8?B?RXlENVRpUXJxUzZUYWtrdXRxaktKdXBUaERmVUtvcWxGWnJQK09kOHBITHEx?=
 =?utf-8?B?REJuOUM1TCtWWXVLK1JLOWF5QTZXWGZLbFl6VHFZUHQ3bzlNbXhuSzVQWWhZ?=
 =?utf-8?B?clhxODM5OXZhVEg1UVNkL2Zzek1rVEJ2THZOd0FpaWE1NE44di92dlNLYjRO?=
 =?utf-8?B?cmxkMWRrVEdlZUhwZ0pGcGFJaW5HSnVRdy9mK3dDdGJpSEdySVFGcWR5SXE4?=
 =?utf-8?B?em9mK3RVQmtUNWpXbzJDeEluVzFYV0lXTGFLQjV0RklXTG96ZzVvNEVoeG0r?=
 =?utf-8?B?Q2VsNHI1T2piamVPUStvMXR5N2c5aklrZHQvdFgySlNXNWxONno1aEErVDhN?=
 =?utf-8?B?RlV3UUZJZ2xEdTFqNGRVNFFlbWpNZEJRanlEUGcvd3lmdlNERkVNRDdpNWls?=
 =?utf-8?B?azkvNXIzRzE1Ny9pbVBtUEp1YWpnVUdiQVdENnJtNlRsZ0g4VHlleEtRaS9E?=
 =?utf-8?B?YjdpZTJ6TG96eGNuRm5wN2xRRGxyTEo4MWNjMnBEVS9pL2pqNUNtbzJtc2xl?=
 =?utf-8?B?b2pZa2Z4VHdrY05hd0ZKdGJ1aWN4cm5IMTc5aExZNFVoVlRQMGl5V2FkU3Zx?=
 =?utf-8?B?UVlBNEExVm5CdDQvWkpzTTd0Q0JiZFBla2o5bGtNREJldkp4T3Y5QVVhWkJr?=
 =?utf-8?B?TC9Fbk0zWDZudkRveWtHdi8wWDZST2xOMlRMaWJFYTN6Qk1KaTJGUzZQMHBh?=
 =?utf-8?B?bmhWOGZreFg2NjJ3Tm55NElINW9hT1JkdmhVQWx3TXhPb28rLzJZVnlYeGpQ?=
 =?utf-8?B?WU0yTnhYaTZVZUNCNW5DNkViOFhzY0MvMWVjdEdFaTQ5ZmVlMEFwL3dhWncw?=
 =?utf-8?B?ZDNGYTlkT2RSeE5EbFhocHBDRG41RlBlOWRhbExMeWFiUGRvZGo4cy9DT3I2?=
 =?utf-8?B?NFZOS3g4MzM3ODhJcFBPUDk2NVlDdjN6WmVoaFlSOXZWZ041S2tENVNOb1k5?=
 =?utf-8?B?bFJSTmpENjRDY1B1WkhYb01BMW00U0I0RTkySzQxY2U3UDBSTVZoUitwU1Ez?=
 =?utf-8?B?R3QyQjFsWFhlY25TRmZxS1MwUlpoRGFiTmJhV1RoZ002TDltZmZ1aTgvZ2RQ?=
 =?utf-8?B?ZWhCSzlUbThrNllSQWl5TGZJZzZQQWNhNi9rWjhmYnJPcmdOek5zMkIrRE8v?=
 =?utf-8?B?SUpYeTM0dU5hNVpZTHNnVzBSMStWVXlHSVhKU1N2UUI5cWpSMTZPOEcyQ3Z6?=
 =?utf-8?B?TUVLdExNTWFwUm44VGJ5VEpMY2d3NEU0MUFEdUtTQjNoNWp4YWJHMlRTK0ls?=
 =?utf-8?B?UjhIWk1XbW5HRVZmLzViU3J6WUx0UmtVZjMyc0NnOGpHZGJWWlpIcTVuTUIr?=
 =?utf-8?B?SEt1bk5YQlpVNjh3dHh4R2V4ZjI3OSsyem9rK0FrRjErT1crcGJrQnJnMEwx?=
 =?utf-8?B?Y2VrdVQ0SjZLRW5zZGs4SFhTaWtMUGVmK2tnQ0paU0phdFBZanNSNDRRUUQ5?=
 =?utf-8?B?M1crbWYvS2hFZGQzdjJaanR3aXRjMlNmRjBWK0RBTG94VU4zVmVqZTNXdldy?=
 =?utf-8?B?aVpBZHQ5cGFXUStVZm1UdUN3a3hDYVNMeGdJRGdVVEpkdkwxbEp3SHk2bG50?=
 =?utf-8?B?bHRGRTc1SnBnZXFXZG9kSCtHM0ZTVE0ybk9SMGczR2QyZGZveDRpeGtKTDhw?=
 =?utf-8?B?OHFrL2d5emtycFVoMTJCeEw3RGJrcENzamFHcnNOUUtkN1haR2VLblRhT2Er?=
 =?utf-8?B?b2dQbDJZZ3pTeE9oTmtWQUR6eThDdkt1R0dNaXVaTlNZK2dmWXdrdzVJaXNE?=
 =?utf-8?B?QUovWXJjRytXVUt1enZxa0RMTGRPdERoNEEwTVI5aDZSZXlmTmJ1emQzWC84?=
 =?utf-8?B?Yk12a2pDNk1ZczExOEJQMy91R1R1SGlMMS9LOWVsS3Z1TlVFZGErYXJnR29Z?=
 =?utf-8?B?Z3pqc1hWbGNnL1AydzBPdUY3eGFjbEo2MVR6cE82dndlUkV0L2JlcFRjc1Vj?=
 =?utf-8?B?SDU4NmI0UHlrV21CMFZJekp4SVdML3MvNmpEL3d1V0VaSjJrT1R1SFZWUE1m?=
 =?utf-8?Q?cAaSMeMh8oX69C4Jykyx1qc=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?UjlTUjE0dmV5MzFpNFA4eTZ3ZG9FTzdMRXpDRGdmbTczNm9VTWZPMmh2RndY?=
 =?utf-8?B?bThPaGpMdmtUcTRkQlJnNkFpaVRvU3dqQ2pzQUUrOGIrakxaVTZieWp4UXNj?=
 =?utf-8?B?NmYvZXZDaFR6b0RzY1hKN0FIWEhJTzdIQ0Nud0VoWFFrd2t4UWhoNDRsRHgw?=
 =?utf-8?B?RGptSjh6aG9jL2pXOXR2Vmc3VUN3V3dsNEx5MHlpSDByL0N5TVZEenJTNUlh?=
 =?utf-8?B?KzBneVdiTWxyOUdvNUNqZmg4QWNnYW5QS1h2WTNCc1ZGT1k3cjd1eUg5Y3hi?=
 =?utf-8?B?TEFmZVFvRFZLWUFGNjREd1JnRFlqN20xWU0yYTJGZ3lKai9FNGR4S3ZaZmd2?=
 =?utf-8?B?bmt1d1hHS1VKSGZtMFduN1p1YVZjdTJQRlpVTEt6WlY5c2ZndktYZUdITzNN?=
 =?utf-8?B?ODU1bUR5d3I1OTErSkcwc3d2Z2lHZmI4YzcrVm50QktObHdVNHRZVVBHR3lR?=
 =?utf-8?B?MGlRYXZ0aHJkWll0V1VmNTliYmh1NW9sMlVTSi81dURYZjZjOStmd3YvUytF?=
 =?utf-8?B?ZmdLVU5aUG5hVkVmQnZTMHN4eUZOOVlFc01lYmdrK1JVNEZqR1p2QkJpd1VP?=
 =?utf-8?B?QXhZcU0yM3BSNUxDVGEwdXlrbXorUmxiWDhhTkZpWVVUN08zdFhHenhwSGZW?=
 =?utf-8?B?SDVXNWhDU2tCS3BJTzJIZVNkZHlBU2lXb3ZMM2NTYmZGYk5UWG8wOEpudTF0?=
 =?utf-8?B?MC9IUHBRb0hmMVlvYkUyM2pTZURQTC84bkwweGJ4Q0JwNjNzdFpEUWxYSmMy?=
 =?utf-8?B?TFN2QWFNSFcrc1JuY0pmQWxYbTMvWmxQaTVNVjRvZVRoeSt1QUw5aU9iblIx?=
 =?utf-8?B?Zks2S1ZpNm5jRFR5dGcvT3JZSnlqWjhEajh0Z2VDcnJxa1pEOWV6cW0ra09x?=
 =?utf-8?B?bVZDTTVRRXRIdVJlZm5IQWRwc0p0NXM0Q0VSM1NrdkNvSS9XNlRRSTFFaFlo?=
 =?utf-8?B?bGZ2dStrZzZoczVyTzFDQjYwNWlIVndJQUNVMDVOSVpNYWlPM05HYzlic0ZV?=
 =?utf-8?B?clJuaWVQVG5SbjY1eE9JMk1LSUZyWVZMaURZQzNNZFl6aVYwNldsQmxXY1RH?=
 =?utf-8?B?NjdqZFlNcnZYYlA2a2ZLRzY4M1lGWG05NE81Z1FibDJBWmd2U2lMaDlQNHF5?=
 =?utf-8?B?djhBL3FrVkFsYUNhbkFtMkdkTXlXaDIybDdsZFg0eFlKa3k5NUNiL1BUR0Rt?=
 =?utf-8?B?RXpBWE5sQ1RDd21hUDR6KzdMTjY3WVV4SWovb0JFNW9iV1lCWW5nTjRaRHg4?=
 =?utf-8?B?NG5zMGxoOWtMQ1pxUTF1SkVyUkRFOW5mQXloRldaOUlJZmtGN3ZZcmd6V1Bk?=
 =?utf-8?B?NlJTR0RIQU9WdjhxcStDVytCakFMRGpkQklRQkcvK2MzMG14WU9QcWsycnkr?=
 =?utf-8?B?ZUdXZW5jZXFIQVVkTTVLTDF5TTR5RldUM29aU0tnY3lxeGttc2ZWdUVPZzFD?=
 =?utf-8?B?b2cwVVI0NnpHV3NsMjdYVjJqMk1lTU9vWlh1cTRNY0kvTkpXVnhVd2xEcEdI?=
 =?utf-8?B?bktiMGQzdlhYV1ZmY3hrZ0NieTJFNGZ1d3VDZ29wSDBrTzJWYjNnQXpSWVdz?=
 =?utf-8?B?K2VsUT09?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b7d676ef-7dc3-4b55-2cf3-08dad32304ff
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5267.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2022 22:34:18.9369
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: H31tvskiepZZ4xyYojtTY+c4YtixkJ7d2sHvwel8GqwbgAeKwAG1HZVRJ3syJRxVR2ZiUudNxs0KwOIim1yS5Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6204
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-30_04,2022-11-30_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=0
 phishscore=0 mlxscore=0 bulkscore=0 spamscore=0 malwarescore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211300159
X-Proofpoint-GUID: l_fb70srVn88d_iq7JPWJJXDkPM-9Kx_
X-Proofpoint-ORIG-GUID: l_fb70srVn88d_iq7JPWJJXDkPM-9Kx_
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 29/11/2022 17:01, Andrii Nakryiko wrote:
> On Tue, Nov 29, 2022 at 5:51 AM Alan Maguire <alan.maguire@oracle.com> wrote:
>>
<snip>>>> I really don't like this approach, even if *technically* it would
>>> work. But even if so, it would add quite a bunch of size to BTF just
>>> to self-describe it.
>>>
>>> Let's go again (and in more detail) over my alternative proposal I
>>> briefly described in another email thread.
>>>
>>> So, what I'm proposing is similar in spirit and solves all the same
>>> goals you have (and actually some more, I'll point this out below).
>>> The only downside is that we'll need to, again, teach kernel to
>>> understand this BTF format extension to allow kernel to use it (so we
>>> still will need an opt-in flag for pahole, unfortunately, but
>>> hopefully just this one time). That's pretty much the only downside.
>>> But it's more compact, simpler and more straightforward, more elegant
>>> (IMO), and it is easy for libbpf to sanitize it for old kernels.
>>>
>>> Ok, so it's pretty much completely described by these changes:
>>>
>>> --- a/include/uapi/linux/btf.h
>>> +++ b/include/uapi/linux/btf.h
>>> @@ -8,6 +8,21 @@
>>>  #define BTF_MAGIC      0xeB9F
>>>  #define BTF_VERSION    1
>>>
>>> +struct btf_kind_meta {
>>> +       /* extra flags, initially define just one:
>>> +        * 0x01 - required or optional (is it safe to skip if unknown)
>>> +        */
>>> +       __u16 flags;
>>> +       __u8 info_sz;
>>> +       __u8 elem_sz;
>>> +};
>>> +
>>> +struct btf_metadata {
>>> +       __u8 kind_meta_cnt;
>>> +       __u32 :0;
>>> +       struct btf_kind_meta[];
>>> +};
>>> +
>>>  struct btf_header {
>>>         __u16   magic;
>>>         __u8    version;
>>> @@ -19,6 +34,8 @@ struct btf_header {
>>>         __u32   type_len;       /* length of type section       */
>>>         __u32   str_off;        /* offset of string section     */
>>>         __u32   str_len;        /* length of string section     */
>>> +       __u32   meta_off;
>>> +       __u32   meta_len;
>>>  };
>>>
>>
>> Ok, if we're going this route though, let's try to think through any
>> other info we need to add so the format changes are a one-time thing.
>> We should add flags too. One current use-case would be the
>> "is this BTF standalone, or does it require base BTF?" [1]. Either using
>> an existing value in the header flags field, or using the space for a flags
>> field in  struct btf_metadata would probably make sense.
> 
> Yes, it's a good idea. But instead of a flag, I wonder if we should
> add some sort of "build ID" concept here, so that we can check
> validity of base BTF as expected by split BTF?
>

I think that would be valuable; it would be great to be able
to spot up-front an incompatibility between split and base
BTF. Are you thinking a hash over the type and string sections
or similar? Any such id shouldn't require actual BTF parsing
I think, since a simple validation could occur absent actual
parsing of the base BTF object. Would we maintain an id 
for base and split BTF, or just record the base id in split BTF
to validate the base? Not needing to recompute the base id
each time for module BTF generation seems like it would make 
it worthwhile to record the BTF id of the current object as well 
as the id of the base object it is built upon.

So something like

struct btf_metadata {
	__u32 id;
	__u32 base_id;
	__u8 kind_meta_cnt;
	__u32 :0;
	struct btf_kind_meta[];
};

...where a 0 base_id implies the object is a root/standalone BTF object?

 
>>
>> Do we have any other outstanding issues with BTF that would be eased
>> by some sort of up-front declaration? If we can at least tackle those
>> things at once, the pain will be somewhat less when updating the toolchain.
> 
> Base vs split BTF + some check whether base BTF is valid is the only
> thing that currently comes to mind.
>

The topic of multiple levels of split BTF has come up before, but I don't 
think that has any additional implications from a metadata perspective;
each level would specify the base_id of the level below.

>>
>>>
>>> So, we add meta_off/meta_len fields to btf_header, which, if non-zero,
>>> will point to a piece of metadata (4-byte aligned) that's described by
>>> struct btf_metadata.
>>>
>>> In btf_metadata, the first byte records the number of known BTF kinds,
>>> we have three more bytes for extra flags or counters for
>>> extensibility, they should be zeroed out right now.
>>>
>>
>> Right; see above for one flags use-case.
>>
>>> After these 4 bytes we have kind_meta_cnt struct btf_kind_meta
>>> entries, each 4-byte long. It's a 1-indexed array, where each entry
>>> corresponds to sequentially numbered BTF kinds. First two bytes are
>>> reserved for flags and stuff like that. Among those, I think the most
>>> useful right now would be the "optional flag". If set, it would mean
>>> that generally speaking it's safe to skip types of that kind without
>>> losing integrity of the data. So e.g., we could have used that for
>>> DECL_TAGS, or perhaps even for FUNCs, if we had this metadata back
>>> then, as these kinds are, generally speaking, not referenced from
>>> other types (not 100% for FUNCs, as we can have FUNC externs, but
>>> those came later). Anyways, for kernel needs we can say that optional
>>> kinds don't cause failure to validate BTF.
>>>
>>
>> This would definitely be useful; but are you saying here that
>> a struct with a reference to an unknown kind should fail BTF
>> validation (something like a struct with an enum64 member parsed by a
>> libbpf prior to enum64 support)? Not sure there's any alternative
>> for a case like that...
> 
> From the kernel validation point -- yes, probably. From generic
> tooling and libbpf-side -- perhaps not. I think kernel will always
> have to be pretty strict due to security reasons.
> 
> 
>>
>>> *But for security reasons we should make the kernel zero-out
>>> corresponding parts of type information, just to prevent injection of
>>> well-known data by malicious user*.
>>>
>>> Next, to the meat of the proposal. info_sz is size in bytes of an
>>> additional singular information (e.g., btf_array for ARRAY kind,
>>> 4-byte info for INT kind, etc) that goes after common 12-byte struct
>>> btf_type. It can be zero, of course. elem_sz is a size in bytes of
>>> each nested element (field info for STRUCT, arg info for FUNC_ARG,
>>> etc). Number of elements is defined by btf_vlen(t), which works for
>>> any kind, regardless if it's known or not. If elem_sz is zero, KIND
>>> can't have nested elements (and thus if vlen is non-zero, that's a
>>> corruption).
>>>
>>> That's it. We don't allow mixing differently-sized nested elements
>>> within a single kind, but we don't have that today and we don't have
>>> any meaningful ways to express this. And I don't think we'd want to do
>>> this anyways (there are way to work around that if absolutely
>>> necessary, as well).
>>>
>>> From libbpf's point of view, this metadata section is easy to
>>> sanitize, as kernel allows btf_headers of bigger size than is known to
>>> it, provided they are zeroed out. So libbpf will just zero out
>>> meta_off/meta_len fields, and contents of the metadata section.
>>>
>>> As for the size, it adds just 8 + 4 + 19 * 4 = 88 bytes to the overall
>>> BTF size. It's nothing. I didn't count the total size for your
>>> approach, but at the very least it would be 19 * 2 * sizeof(struct
>>> btf_type) (=12) = 456, but that's super conservative.
>>>
>>> Note also that each btf_type can always have a name (described by
>>> btf_type->name_off), so generic BTF tools can easily output what is
>>> the name of the skipped entity, regardless of its actual kind. Tools
>>> can also point out how many nested elements it is supposed to have.
>>> Both are quite nice features, IMO.
>>>
>>> Anyways, that's what I had in mind. I think we should bite a bullet
>>> and do it, so that future extensions can make use of this
>>> self-describing metadata.
>>>
>>> Thoughts?
>>>
>>
>> It'll work, a few specific questions we should probably resolve up front:
>>
>> - We can deduce the presence of the metadata info from the header length, so we
>>   don't need a BTF version bump, right?
> 
> yep
> 
>>
>> - from the encoding perspective, you mentioned having metadata opt-in;
>>   so I presume we'd have a btf__add_metadata() API (it is zero by default so
>>   accepted by the kernel I think) if --encode_metadata is set? Perhaps eventually
>>   we could move to opt-out.
> 
> I'd say that btf__new() should by default produce metadata, unless
> opted out through opts. But pahole should default for opt-out to not
> regress on old kernels built with new pahole.
> 

Ok; we'll need new APIs btf__new_empty[_split]_opts() to handle this I think.

Alan

>>
>> - there are some cases where what is valid has evolved over time. For example,
>>   kind flags have appeared for some kinds; should we have a flag for "supports kind
>>   flag"? (set for struct/union/enum/fwd/eum64)?
>>
> 
> "supports kind flag" seems way too specific, tbh. Seems wrong to have
> such a flag.
> 
> 
>> I can probably respin what I have, unless you want to take it on?
> 
> Let's discuss base vs split BTF identification first.
> 
>>
>> [1] https://lore.kernel.org/bpf/CAEf4BzYXRT9pFmC1RqnNBmvQWGQkd0zs9rbH9z9Ug8FWOArb_Q@mail.gmail.com/
>>
>>>
>>>> +
>>>> +/* info used to encode a kind metadata field */
>>>> +struct btf_meta_field {
>>>> +       const char *type;
>>>> +       const char *name;
>>>> +       int size;
>>>> +       int type_id;
>>>> +};
>>>> +
>>>> +#define BTF_MAX_META_FIELDS             10
>>>> +
>>>> +#define BTF_META_FIELD(__type, __name)                                 \
>>>> +       { .type = #__type, .name = #__name, .size = sizeof(__type) }
>>>> +
>>>> +#define BTF_KIND_STR(__kind)   #__kind
>>>> +
>>>> +struct btf_kind_encoding {
>>>> +       struct btf_kind_desc kind;
>>>> +       struct btf_meta_field meta[BTF_MAX_META_FIELDS];
>>>> +};
>>>> +
>>>> +#define BTF_KIND(__name, __nr_meta, __meta_size, ...)                  \
>>>> +       { .kind = {                                                     \
>>>> +         .kind = BTF_KIND_##__name,                                    \
>>>> +         .struct_name = BTF_KIND_PFX#__name,                           \
>>>> +         .meta_name = BTF_KIND_META_PFX #__name,                       \
>>>> +         .nr_meta = __nr_meta,                                         \
>>>> +         .meta_size = __meta_size,                                     \
>>>> +       }, .meta = { __VA_ARGS__ } }
>>>> +
>>>> +struct btf_kind_encoding kinds[] = {
>>>> +       BTF_KIND(UNKN,          0,      0),
>>>> +
>>>> +       BTF_KIND(INT,           0,      0),
>>>> +
>>>> +       BTF_KIND(PTR,           0,      0),
>>>> +
>>>> +       BTF_KIND(ARRAY,         1,      sizeof(struct btf_array),
>>>> +                                       BTF_META_FIELD(__u32, type),
>>>> +                                       BTF_META_FIELD(__u32, index_type),
>>>> +                                       BTF_META_FIELD(__u32, nelems)),
>>>> +
>>>> +       BTF_KIND(STRUCT,        0,      sizeof(struct btf_member),
>>>> +                                       BTF_META_FIELD(__u32, name_off),
>>>> +                                       BTF_META_FIELD(__u32, type),
>>>> +                                       BTF_META_FIELD(__u32, offset)),
>>>> +
>>>> +       BTF_KIND(UNION,         0,      sizeof(struct btf_member),
>>>> +                                       BTF_META_FIELD(__u32, name_off),
>>>> +                                       BTF_META_FIELD(__u32, type),
>>>> +                                       BTF_META_FIELD(__u32, offset)),
>>>> +
>>>> +       BTF_KIND(ENUM,          0,      sizeof(struct btf_enum),
>>>> +                                       BTF_META_FIELD(__u32, name_off),
>>>> +                                       BTF_META_FIELD(__s32, val)),
>>>> +
>>>> +       BTF_KIND(FWD,           0,      0),
>>>> +
>>>> +       BTF_KIND(TYPEDEF,       0,      0),
>>>> +
>>>> +       BTF_KIND(VOLATILE,      0,      0),
>>>> +
>>>> +       BTF_KIND(CONST,         0,      0),
>>>> +
>>>> +       BTF_KIND(RESTRICT,      0,      0),
>>>> +
>>>> +       BTF_KIND(FUNC,          0,      0),
>>>> +
>>>> +       BTF_KIND(FUNC_PROTO,    0,      sizeof(struct btf_param),
>>>> +                                       BTF_META_FIELD(__u32, name_off),
>>>> +                                       BTF_META_FIELD(__u32, type)),
>>>> +
>>>> +       BTF_KIND(VAR,           1,      sizeof(struct btf_var),
>>>> +                                       BTF_META_FIELD(__u32, linkage)),
>>>> +
>>>> +       BTF_KIND(DATASEC,       0,      sizeof(struct btf_var_secinfo),
>>>> +                                       BTF_META_FIELD(__u32, type),
>>>> +                                       BTF_META_FIELD(__u32, offset),
>>>> +                                       BTF_META_FIELD(__u32, size)),
>>>> +
>>>> +
>>>> +       BTF_KIND(FLOAT,         0,      0),
>>>> +
>>>> +       BTF_KIND(DECL_TAG,      1,      sizeof(struct btf_decl_tag),
>>>> +                                       BTF_META_FIELD(__s32, component_idx)),
>>>> +
>>>> +       BTF_KIND(TYPE_TAG,      0,      0),
>>>> +
>>>> +       BTF_KIND(ENUM64,        0,      sizeof(struct btf_enum64),
>>>> +                                       BTF_META_FIELD(__u32, name_off),
>>>> +                                       BTF_META_FIELD(__u32, val_lo32),
>>>> +                                       BTF_META_FIELD(__u32, val_hi32)),
>>>> +};
>>>> +
>>>> +/* Try to add representations of the kinds supported to BTF provided.  This will allow parsers
>>>> + * to decode kinds they do not support and skip over them.
>>>> + */
>>>> +int btf__add_kinds(struct btf *btf)
>>>> +{
>>>> +       int btf_type_id, __u32_id, __s32_id, struct_type_id;
>>>> +       char name[64];
>>>> +       int i;
>>>> +
>>>> +       /* should have base types; if not bootstrap them. */
>>>> +       __u32_id = btf__find_by_name(btf, "__u32");
>>>> +       if (__u32_id < 0) {
>>>> +               __s32 unsigned_int_id = btf__find_by_name(btf, "unsigned int");
>>>> +
>>>> +               if (unsigned_int_id < 0)
>>>> +                       unsigned_int_id = btf__add_int(btf, "unsigned int", 4, 0);
>>>> +               __u32_id = btf__add_typedef(btf, "__u32", unsigned_int_id);
>>>> +       }
>>>> +       __s32_id = btf__find_by_name(btf, "__s32");
>>>> +       if (__s32_id < 0) {
>>>> +               __s32 int_id = btf__find_by_name_kind(btf, "int", BTF_KIND_INT);
>>>> +
>>>> +               if (int_id < 0)
>>>> +                       int_id = btf__add_int(btf, "int", 4, BTF_INT_SIGNED);
>>>> +               __s32_id = btf__add_typedef(btf, "__s32", int_id);
>>>> +       }
>>>> +
>>>> +       /* add "struct __btf_type" if not already present. */
>>>> +       btf_type_id = btf__find_by_name(btf, "__btf_type");
>>>> +       if (btf_type_id < 0) {
>>>> +               __s32 union_id = btf__add_union(btf, NULL, sizeof(__u32));
>>>> +
>>>> +               btf__add_field(btf, "size", __u32_id, 0, 0);
>>>> +               btf__add_field(btf, "type", __u32_id, 0, 0);
>>>> +
>>>> +               btf_type_id = btf__add_struct(btf, "__btf_type", sizeof(struct btf_type));
>>>> +               btf__add_field(btf, "name_off", __u32_id, 0, 0);
>>>> +               btf__add_field(btf, "info", __u32_id, sizeof(__u32) * 8, 0);
>>>> +               btf__add_field(btf, NULL, union_id, sizeof(__u32) * 16, 0);
>>>> +       }
>>>> +
>>>> +       for (i = 0; i < ARRAY_SIZE(kinds); i++) {
>>>> +               struct btf_kind_encoding *kind = &kinds[i];
>>>> +               int meta_id, array_id = 0;
>>>> +
>>>> +               if (btf__find_by_name(btf, kind->kind.struct_name) > 0)
>>>> +                       continue;
>>>> +
>>>> +               if (kind->kind.meta_size != 0) {
>>>> +                       struct btf_meta_field *field;
>>>> +                       __u32 bit_offset = 0;
>>>> +                       int j;
>>>> +
>>>> +                       meta_id = btf__add_struct(btf, kind->kind.meta_name, kind->kind.meta_size);
>>>> +
>>>> +                       for (j = 0; bit_offset < kind->kind.meta_size * 8; j++) {
>>>> +                               field = &kind->meta[j];
>>>> +
>>>> +                               field->type_id = btf__find_by_name(btf, field->type);
>>>> +                               if (field->type_id < 0) {
>>>> +                                       pr_debug("cannot find type '%s' for kind '%s' field '%s'\n",
>>>> +                                                kind->meta[j].type, kind->kind.struct_name,
>>>> +                                                kind->meta[j].name);
>>>> +                               } else {
>>>> +                                       btf__add_field(btf, field->name, field->type_id, bit_offset, 0);
>>>> +                               }
>>>> +                               bit_offset += field->size * 8;
>>>> +                       }
>>>> +                       array_id = btf__add_array(btf, __u32_id, meta_id,
>>>> +                                                 kind->kind.nr_meta);
>>>> +
>>>> +               }
>>>> +               struct_type_id = btf__add_struct(btf, kind->kind.struct_name,
>>>> +                                                sizeof(struct btf_type) +
>>>> +                                                (kind->kind.nr_meta * kind->kind.meta_size));
>>>> +               btf__add_field(btf, "type", btf_type_id, 0, 0);
>>>> +               if (kind->kind.meta_size != 0)
>>>> +                       btf__add_field(btf, "meta", array_id, sizeof(struct btf_type) * 8, 0);
>>>> +               snprintf(name, sizeof(name), BTF_KIND_PFX "%u", i);
>>>> +               btf__add_typedef(btf, name, struct_type_id);
>>>> +       }
>>>> +       return 0;
>>>> +}
>>>> diff --git a/tools/lib/bpf/btf.h b/tools/lib/bpf/btf.h
>>>> index 8e6880d..a054082 100644
>>>> --- a/tools/lib/bpf/btf.h
>>>> +++ b/tools/lib/bpf/btf.h
>>>> @@ -219,6 +219,16 @@ LIBBPF_API int btf__add_datasec_var_info(struct btf *btf, int var_type_id,
>>>>  LIBBPF_API int btf__add_decl_tag(struct btf *btf, const char *value, int ref_type_id,
>>>>                             int component_idx);
>>>>
>>>> +/**
>>>> + * @brief **btf__add_kinds()** adds BTF representations of the kind encoding for
>>>> + * all of the kinds known to libbpf.  This ensures that when BTF is encoded, it
>>>> + * will include enough information for parsers to decode (and skip over) kinds
>>>> + * that the parser does not know about yet.  This ensures that an older BTF
>>>> + * parser can read newer BTF, and avoids the need for the BTF encoder to limit
>>>> + * which kinds it emits to make decoding easier.
>>>> + */
>>>> +LIBBPF_API int btf__add_kinds(struct btf *btf);
>>>> +
>>>>  struct btf_dedup_opts {
>>>>         size_t sz;
>>>>         /* optional .BTF.ext info to dedup along the main BTF info */
>>>> diff --git a/tools/lib/bpf/libbpf.map b/tools/lib/bpf/libbpf.map
>>>> index 71bf569..6121ff1 100644
>>>> --- a/tools/lib/bpf/libbpf.map
>>>> +++ b/tools/lib/bpf/libbpf.map
>>>> @@ -375,6 +375,7 @@ LIBBPF_1.1.0 {
>>>>                 bpf_link_get_fd_by_id_opts;
>>>>                 bpf_map_get_fd_by_id_opts;
>>>>                 bpf_prog_get_fd_by_id_opts;
>>>> +               btf__add_kinds;
>>>>                 user_ring_buffer__discard;
>>>>                 user_ring_buffer__free;
>>>>                 user_ring_buffer__new;
>>>> --
>>>> 1.8.3.1
>>>>
